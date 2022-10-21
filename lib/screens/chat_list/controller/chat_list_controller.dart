import 'package:get/get.dart';

import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/models/chat_conversation_model.dart';
import 'package:play_workout/models/chat_pattern_model.dart';
import 'package:play_workout/models/enum/notification_type.dart';
import 'package:play_workout/models/notification_model.dart';
import 'package:play_workout/routes/routes.dart';
import 'package:play_workout/screens/chat_list/service/chat_list_service.dart';
import 'package:play_workout/services/local_storage.dart';

class ChatListController extends GetxController
    with StateMixin<List<NotificationMessageModel>> {
  ChatListService service;
  ChatListController({
    required this.service,
  });

  GlobalController globalController = GlobalController.i;
  bool isClient = true;
  List<NotificationMessageModel> notificationMessage = [];
  @override
  void onInit() async {
    super.onInit();
    isClient = await LocalStorage.getIsClients();
    change(notificationMessage, status: RxStatus.loading());

    change(
      await getLastMessagesFromNotifications(),
      status:
          notificationMessage.isEmpty ? RxStatus.empty() : RxStatus.success(),
    );

    while (true) {
      await Future.delayed(const Duration(seconds: 30));
      change(
        await getLastMessagesFromNotifications(),
        status:
            notificationMessage.isEmpty ? RxStatus.empty() : RxStatus.success(),
      );
    }
  }

  Future<List<NotificationMessageModel>>
      getLastMessagesFromNotifications() async {
    notificationMessage.clear();
    var conversations = await service.getConversations();

    if (conversations.isEmpty) {
      return notificationMessage;
    }

    var peopleIds = <String>[];

    for (var item in conversations) {
      if (isClient) {
        peopleIds.add(item.trainer);
      } else {
        peopleIds.add(item.client);
      }
    }
    var people = await service.getPeople(peopleIds);
    var notifications = globalController.notifications?.notifications
        .where((element) => element.type == NotificationType.message)
        .toList();
    notifications?.sort((a, b) => b.date.compareTo(a.date));

    var index = 0;
    for (var person in people) {
      notificationMessage.add(NotificationMessageModel(
        name: isClient ? person['first_name'] : person['name'],
      ));
      if (isClient) {
        if (conversations
            .any((element) => element.trainer == person['trainer_id'])) {
          notificationMessage[index].chatConversation =
              conversations.firstWhereOrNull(
                  (element) => element.trainer == person['trainer_id']);
        }
      } else {
        if (conversations
            .any((element) => element.client == person['client_id'])) {
          notificationMessage[index].chatConversation =
              conversations.firstWhereOrNull(
                  (element) => element.client == person['client_id']);
        }
      }
      if (notifications != null) {
        if (notifications.any(
          (element) => notificationMessage[index]
              .chatConversation!
              .messages!
              .any((e) => e.notificationId == element.id),
        )) {
          notificationMessage[index].notifications = notifications.where(
            (element) {
              return notificationMessage[index]
                  .chatConversation!
                  .messages!
                  .any((e) => e.notificationId == element.id);
            },
          ).toList();
        }
      }
      index++;
    }

    return notificationMessage;
  }

  Future<void> getLastMessagesFromConversation() async {
    isClient ? globalController.getTrainer() : globalController.getClient();
  }

  Future<void> goToChat(ChatPatternModel chatPattern,
      List<NotificationModel>? notifications) async {
    change(
      state,
      status: RxStatus.loading(),
    );
    List<String> ids = [];
    if (notifications != null) {
      for (var item in notifications) {
        if (!item.read) {
          ids.add(item.id);
        }
      }
      await globalController.readNotification(notificationIds: ids);
    }
    change(
      await getLastMessagesFromNotifications(),
      status: RxStatus.success(),
    );
    Get.toNamed(Routes.toChat, arguments: chatPattern);
  }
}

class NotificationMessageModel {
  String? name;
  ChatConversationModel? chatConversation;
  List<NotificationModel>? notifications;

  NotificationMessageModel({
    this.name,
    this.chatConversation,
    this.notifications,
  });
}
