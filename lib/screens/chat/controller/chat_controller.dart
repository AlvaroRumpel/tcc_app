import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_workout/config/database_variables.dart';
import 'package:play_workout/config/notifications/custom_firebase_messaging.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/models/chat_conversation_model.dart';
import 'package:play_workout/models/chat_pattern_model.dart';
import 'package:play_workout/models/enum/notification_type.dart';
import 'package:play_workout/models/message_model.dart';
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
  // bool isClient = true;
  // String id = "";
  // String? fcmTokenSend;
  ChatPatternModel? chatArguments;

  @override
  void onInit() async {
    super.onInit();
    change(state, status: RxStatus.loading());
    // isClient = isClientCheck();
    chatArguments = arguments;
    await getConversationId();
    listenMessages();
  }

  // bool isClientCheck() {
  //   if (arguments is UserTrainerModel) {
  //     id = arguments.clientId;
  //     fcmTokenSend = arguments.fcmToken;
  //     return false;
  //   } else if (arguments is WorkoutsModel) {
  //     id = arguments.trainerId;
  //   } else if (arguments is TrainerModel) {
  //     id = arguments.trainerId;
  //     fcmTokenSend = arguments.fcmToken;
  //   }
  //   return true;
  // }

  Future<void> getConversationId() async {
    try {
      response = await db
          .where(
            'client',
            isEqualTo: chatArguments!.isClient
                ? chatArguments!.senderId ??
                    FirebaseAuth.instance.currentUser?.uid
                : chatArguments!.receiverId,
            // isClient ? FirebaseAuth.instance.currentUser?.uid ?? '' : id,
          )
          .where(
            'trainer',
            isEqualTo: !chatArguments!.isClient
                ? chatArguments!.senderId ??
                    FirebaseAuth.instance.currentUser?.uid
                : chatArguments!.receiverId,
            // !isClient ? FirebaseAuth.instance.currentUser?.uid ?? '' : id,
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
        whoReceived: chatArguments!.receiverId,
        whoSent: FirebaseAuth.instance.currentUser!.uid,
      );

      messageController.clear();

      if (messageList != null) {
        messageList!.messages!.insert(0, message);
        messageList!.clientFcmToken = chatArguments!.isClient
            ? await LocalStorage.getFirebaseToken()
            : messageList!.clientFcmToken;
        messageList!.trainerFcmToken = !chatArguments!.isClient
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
          trainer: !chatArguments!.isClient
              ? chatArguments!.senderId ??
                  FirebaseAuth.instance.currentUser?.uid ??
                  ''
              : chatArguments!.receiverId,
          client: chatArguments!.isClient
              ? chatArguments!.senderId ??
                  FirebaseAuth.instance.currentUser?.uid ??
                  ''
              : chatArguments!.receiverId,
          trainerFcmToken: !chatArguments!.isClient
              ? await LocalStorage.getFirebaseToken()
              : chatArguments!.fcmTokenToSend,
          clientFcmToken: chatArguments!.isClient
              ? await LocalStorage.getFirebaseToken()
              : chatArguments!.fcmTokenToSend,
        );
        var response = await FirebaseFirestore.instance
            .collection(DB.conversation)
            .add(messageComplete.toMap());
        docId = response.id;
        listenMessages();
      }

      if (messageList == null) return;

      String to = '';

      if (!chatArguments!.isClient && messageList!.clientFcmToken != null) {
        to = messageList!.clientFcmToken!;
      } else if (chatArguments!.isClient &&
          messageList!.trainerFcmToken != null) {
        to = messageList!.trainerFcmToken!;
      }

      if (to != '') {
        await CustomFirebaseMessaging().sendNotification(
          to: to,
          title:
              'Nova Mensagem de ${chatArguments!.isClient ? GlobalController.i.client!.name : GlobalController.i.trainer!.firstName}',
          body: messageList!.messages!.first.message,
          toClient: !chatArguments!.isClient,
          notificationType: NotificationType.message,
          personId: chatArguments!.receiverId,
          plusData: ChatPatternModel(
            isClient: !chatArguments!.isClient,
            receiverId: chatArguments?.senderId ??
                FirebaseAuth.instance.currentUser?.uid ??
                '',
            fcmTokenToSend: await LocalStorage.getFirebaseToken(),
            senderId: chatArguments!.receiverId,
          ),
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
