import 'dart:convert';

import 'package:play_workout/models/notification_model.dart';

class NotificationsListModel {
  String? id;
  List<NotificationModel> notifications;
  String personId;

  NotificationsListModel({
    this.id,
    required this.notifications,
    required this.personId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'notifications': notifications.map((x) => x.toMap()).toList(),
      'person_id': personId,
    };
  }

  factory NotificationsListModel.fromMap(Map<String, dynamic> map, String? id) {
    return NotificationsListModel(
      id: map['id'] ?? id,
      notifications: List<NotificationModel>.from(
          map['notifications']?.map((x) => NotificationModel.fromMap(x))),
      personId: map['person_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationsListModel.fromJson(String source, String? id) =>
      NotificationsListModel.fromMap(json.decode(source), id);
}
