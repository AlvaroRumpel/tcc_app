import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/models/chat_pattern_model.dart';
import 'package:play_workout/models/enum/notification_type.dart';
import 'package:play_workout/models/notification_model.dart';
import 'package:play_workout/routes/routes.dart';

class NotificationsController extends GetxController
    with StateMixin<List<List<NotificationModel>>> {
  GlobalController globalController = GlobalController.i;

  @override
  Future<void> onInit() async {
    change(state, status: RxStatus.loading());
    super.onInit();
    change(
      getNotifications(),
      status: globalController.notifications == null ||
              globalController.notifications!.notifications.isEmpty
          ? RxStatus.empty()
          : RxStatus.success(),
    );
    while (true) {
      await Future.delayed(const Duration(seconds: 10));
      change(
        getNotifications(),
        status: globalController.notifications == null ||
                globalController.notifications!.notifications.isEmpty
            ? RxStatus.empty()
            : RxStatus.success(),
      );
    }
  }

  List<List<NotificationModel>> getNotifications() {
    var groups = <List<NotificationModel>>[];
    for (var item in globalController.notifications!.notifications) {
      if (groups
          .any((element) => element.every((e) => e.title == item.title))) {
        groups[groups.indexWhere(
                (element) => element.every((e) => e.title == item.title))]
            .add(item);
      } else {
        groups.add([item]);
      }

      for (var item in groups) {
        item.sort(
          (a, b) => b.date.compareTo(a.date),
        );
      }
    }
    return groups;
  }

  Future<void> goToNotification(List<NotificationModel> notifications) async {
    try {
      List<String> ids = [];
      for (var item in notifications) {
        ids.add(item.id);
      }
      await globalController.readNotification(notificationIds: ids);
      if (notifications.first.type == NotificationType.message) {
        await Get.toNamed(
          Routes.toChat,
          arguments: ChatPatternModel.fromJson(notifications
              .firstWhere((element) => element.plusData != '')
              .plusData),
        );
      }
      change(
        getNotifications(),
        status: globalController.notifications == null ||
                globalController.notifications!.notifications.isEmpty
            ? RxStatus.empty()
            : RxStatus.success(),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
