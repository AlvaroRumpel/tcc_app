import 'dart:convert';

class ChatPatternModel {
  String? senderId;
  String receiverId;
  String? fcmTokenToSend;
  bool isClient;
  ChatPatternModel({
    this.senderId,
    required this.receiverId,
    this.fcmTokenToSend,
    required this.isClient,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'fcmTokenToSend': fcmTokenToSend,
      'isClient': isClient,
    };
  }

  factory ChatPatternModel.fromMap(Map<String, dynamic> map) {
    return ChatPatternModel(
      senderId: map['senderId'],
      receiverId: map['receiverId'] ?? '',
      fcmTokenToSend: map['fcmTokenToSend'],
      isClient: map['isClient'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatPatternModel.fromJson(String source) =>
      ChatPatternModel.fromMap(json.decode(source));
}
