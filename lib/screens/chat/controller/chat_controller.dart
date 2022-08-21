import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/config/database_variables.dart';
import 'package:tcc_app/models/chat_conversation_model.dart';
import 'package:tcc_app/models/message_model.dart';
import 'package:tcc_app/services/local_storage.dart';

class ChatController extends GetxController
    with StateMixin<ChatConversationModel> {
  ChatController({Key? key});
  QuerySnapshot<Map<String, dynamic>>? response;

  String id = Get.parameters.values.first ?? '';

  TextEditingController messageController = TextEditingController();

  CollectionReference<Map<String, dynamic>> db =
      FirebaseFirestore.instance.collection(DB.conversation);

  ChatConversationModel? messageList;
  String? docId;
  bool isClient = true;

  @override
  void onInit() async {
    super.onInit();
    change(state, status: RxStatus.loading());
    isClient = await LocalStorage.getIsClients();
    await getConversationId();
    listenMessages();
  }

  Future<void> getConversationId() async {
    try {
      response = await db
          .where(
            'client',
            isEqualTo:
                isClient ? FirebaseAuth.instance.currentUser?.uid ?? '' : id,
          )
          .where(
            'trainer',
            isEqualTo:
                !isClient ? FirebaseAuth.instance.currentUser?.uid ?? '' : id,
          )
          .get();
      docId = response?.docs.first.id;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      change(messageList, status: RxStatus.empty());
    }
  }

  Stream<void>? listenMessages() {
    try {
      if (docId != null) {
        db.doc(docId).snapshots().listen(
          (event) {
            messageList =
                ChatConversationModel.fromMap(event.data()!, event.id);
            change(
              messageList,
              status:
                  messageList == null ? RxStatus.empty() : RxStatus.success(),
            );
          },
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<void> sendMessage() async {
    if (messageController.text.isEmpty) {
      return;
    }
    try {
      var message = MessageModel(
        message: messageController.text,
        sendDate: DateTime.now().toString(),
        whoReceived: id,
        whoSent: FirebaseAuth.instance.currentUser!.uid,
      );

      if (messageList != null) {
        messageList!.messages!.insert(0, message);
        await FirebaseFirestore.instance
            .collection(DB.conversation)
            .doc(messageList?.id)
            .set(
              messageList!.toMap(),
              SetOptions(merge: true),
            );
      } else {
        var messageComplete = ChatConversationModel(
          messages: [message],
          trainer: !isClient ? FirebaseAuth.instance.currentUser!.uid : id,
          client: isClient ? FirebaseAuth.instance.currentUser!.uid : id,
        );
        var response = await FirebaseFirestore.instance
            .collection(DB.conversation)
            .add(messageComplete.toMap());
        docId = response.id;
        listenMessages();
      }
      messageController.clear();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
