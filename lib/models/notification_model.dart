import 'dart:convert';

import 'package:play_workout/models/enum/notification_type.dart';

class NotificationModel {
  String title;
  String body;
  NotificationType type;
  String plusData;
  DateTime date;
  bool read;
  String id;

  NotificationModel({
    required this.title,
    required this.body,
    required this.type,
    required this.plusData,
    required this.date,
    required this.read,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'type': notificationTypeToIntConvertion(type),
      'plus_data': plusData,
      'date': date,
      'read': read,
      'id': id,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      type: intToNotificationTypeConvertion(map['type'].toInt()),
      plusData: map['plus_data'] ?? '',
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['date'].millisecondsSinceEpoch)
          : DateTime.now(),
      read: map['read'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  static NotificationType intToNotificationTypeConvertion(int value) {
    switch (value) {
      case 0:
        return NotificationType.message;
      case 1:
        return NotificationType.contract;
      case 2:
        return NotificationType.rating;
      default:
        return NotificationType.contract;
    }
  }

  static int notificationTypeToIntConvertion(NotificationType value) {
    switch (value) {
      case NotificationType.message:
        return 0;
      case NotificationType.contract:
        return 1;
      case NotificationType.rating:
        return 2;
    }
  }
}
