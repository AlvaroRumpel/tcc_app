import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tcc_app/config/notifications/custom_local_notification.dart';
import 'package:http/http.dart' as http;
import 'package:tcc_app/config/notifications/firebase_variables.dart';
import 'dart:convert' show json;

import 'package:tcc_app/services/local_storage.dart';

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
      Get.offAllNamed(event.data['goTD']);
    });
  }

  getTokenFirebase() async {
    String token = await FirebaseMessaging.instance.getToken() ?? '';
    debugPrint('TOKEN: $token');
    if (token.isNotEmpty) await LocalStorage.setFirebaseToken(token);
  }

  Future<void> sendNotification(String to, String title, String body) async {
    try {
      final dynamic data = json.encode({
        'to': to,
        'priority': 'high',
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

      debugPrint(response.statusCode.toString());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
