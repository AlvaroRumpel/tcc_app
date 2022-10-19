import 'dart:convert';

class MessageModel {
  String message;
  String whoSent;
  String whoReceived;
  String sendDate;
  String notificationId;

  MessageModel({
    required this.message,
    required this.whoSent,
    required this.whoReceived,
    required this.sendDate,
    required this.notificationId,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'who_sent': whoSent,
      'who_received': whoReceived,
      'send_date': sendDate,
      'notification_id': notificationId,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] ?? '',
      whoSent: map['who_sent'] ?? '',
      whoReceived: map['who_received'] ?? '',
      sendDate: map['send_date'] ?? '',
      notificationId: map['notification_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));
}
