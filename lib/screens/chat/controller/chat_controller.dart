import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_workout/config/database_variables.dart';
import 'package:play_workout/config/notifications/custom_firebase_messaging.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/models/chat_conversation_model.dart';
import 'package:play_workout/models/message_model.dart';
import 'package:play_workout/models/trainer_model.dart';
import 'package:play_workout/models/user_trainer_model.dart';
import 'package:play_workout/models/workouts_model.dart';
import 'package:play_workout/services/local_storage.dart';
import 'package:play_workout/utils/utils_widgets.dart';

class ChatController extends GetxController
    with StateMixin<ChatConversationModel> {
  ChatController({Key? key});
  QuerySnapshot<Map<String, dynamic>>? response;

  var arguments = Get.arguments ?? '';

  TextEditingController messageController = TextEditingController();

  CollectionReference<Map<String, dynamic>> db =
      FirebaseFirestore.instance.collection(DB.conversation);

  ChatConversationModel? messageList;
  String? docId;
  bool isClient = true;
  String id = "";
  String? fcmTokenSend;

  @override
  void onInit() async {
    super.onInit();
    change(state, status: RxStatus.loading());
    isClient = isClientCheck();
    await getConversationId();
    listenMessages();
  }

  bool isClientCheck() {
    if (arguments is UserTrainerModel) {
      id = arguments.clientId;
      fcmTokenSend = arguments.fcmToken;
      return false;
    } else if (arguments is WorkoutsModel) {
      id = arguments.trainerId;
    } else if (arguments is TrainerModel) {
      id = arguments.trainerId;
      fcmTokenSend = arguments.fcmToken;
    }
    return true;
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

      messageController.clear();

      if (messageList != null) {
        messageList!.messages!.insert(0, message);
        messageList!.clientFcmToken = isClient
            ? await LocalStorage.getFirebaseToken()
            : messageList!.clientFcmToken;
        messageList!.trainerFcmToken = !isClient
            ? await LocalStorage.getFirebaseToken()
            : messageList!.trainerFcmToken;
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
          trainerFcmToken:
              !isClient ? await LocalStorage.getFirebaseToken() : fcmTokenSend,
          clientFcmToken:
              isClient ? await LocalStorage.getFirebaseToken() : fcmTokenSend,
        );
        var response = await FirebaseFirestore.instance
            .collection(DB.conversation)
            .add(messageComplete.toMap());
        docId = response.id;
        listenMessages();
      }

      if (messageList == null) return;

      String to = '';

      if (!isClient && messageList!.clientFcmToken != null) {
        to = messageList!.clientFcmToken!;
      } else if (isClient && messageList!.trainerFcmToken != null) {
        to = messageList!.trainerFcmToken!;
      }

      if (to != '') {
        await CustomFirebaseMessaging().sendNotification(
          to,
          'Nova Mensagem de ${isClient ? GlobalController.i.client!.name : GlobalController.i.trainer!.firstName}',
          messageList!.messages!.first.message,
          !isClient,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      UtilsWidgets.errorSnackbar();
    }
  }
}
