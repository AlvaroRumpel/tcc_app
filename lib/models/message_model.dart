import 'dart:convert';

class MessageModel {
  String message;
  String whoSent;
  String whoReceived;
  String sendDate;

  MessageModel({
    required this.message,
    required this.whoSent,
    required this.whoReceived,
    required this.sendDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'who_sent': whoSent,
      'who_received': whoReceived,
      'send_date': sendDate,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] ?? '',
      whoSent: map['who_sent'] ?? '',
      whoReceived: map['who_received'] ?? '',
      sendDate: map['send_date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));
}
