import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:play_workout/config/notifications/custom_local_notification.dart';
import 'package:http/http.dart' as http;
import 'package:play_workout/config/notifications/firebase_variables.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/models/enum/notification_type.dart';
import 'package:play_workout/models/notification_model.dart';
import 'package:play_workout/routes/routes.dart';
import 'dart:convert' show json;

import 'package:play_workout/services/local_storage.dart';
import 'package:uuid/uuid.dart';

class CustomFirebaseMessaging {
  final CustomLocalNotification _customLocalNotification;

  CustomFirebaseMessaging._internal(this._customLocalNotification);
  static final CustomFirebaseMessaging _singleton =
      CustomFirebaseMessaging._internal(CustomLocalNotification());
  factory CustomFirebaseMessaging() => _singleton;

  Future<void> initialize() async {
    await FirebaseMessaging.instance.requestPermission(
      badge: true,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((event) {
      RemoteNotification? notification = event.notification;
      AndroidNotification? android = event.notification?.android;

      if (notification != null && android != null) {
        _customLocalNotification.androidNotification(notification, android);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      NotificationType notificationType =
          NotificationModel.intToNotificationTypeConvertion(
              event.data['notification_type'].toInt());
      if (notificationType == NotificationType.contract) {
        Get.offAllNamed(
          event.data['toClient'] ? Routes.toHomeClient : Routes.toHomeTrainer,
        );
      }
      if (notificationType == NotificationType.message) {
        Get.toNamed(Routes.toNotifications, arguments: event.data['plus_data']);
      }
    });
  }

  getTokenFirebase() async {
    String token = await FirebaseMessaging.instance.getToken() ?? '';
    debugPrint('TOKEN: $token');
    if (token.isNotEmpty) await LocalStorage.setFirebaseToken(token);
  }

  Future<void> sendNotification({
    String? relationId,
    required String to,
    required String title,
    required String body,
    required bool toClient,
    dynamic plusData = '',
    required NotificationType notificationType,
    required String personId,
  }) async {
    try {
      final dynamic data = json.encode({
        'to': to,
        'priority': 'high',
        'data': {
          'toClient': toClient,
          'plus_data': plusData,
          'notification_type':
              NotificationModel.notificationTypeToIntConvertion(
                  notificationType),
        },
        'notification': {
          'title': title,
          'body': body,
        },
        'content_available': true
      });

      var response = await http.post(
        Uri.parse(FirebaseVariables.endPoint),
        body: data,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': FirebaseVariables.auth,
        },
      );
      GlobalController.i.setNotifications(
        notification: NotificationModel(
          id: relationId ?? const Uuid().v4(),
          title: title,
          body: body,
          type: notificationType,
          plusData: plusData is String ? plusData : plusData.toJson(),
          date: DateTime.now(),
          read: false,
        ),
        personId: personId,
      );
      debugPrint(response.statusCode.toString());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
