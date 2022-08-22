import 'dart:convert';
import 'package:tcc_app/models/message_model.dart';

class ChatConversationModel {
  String? id;
  List<MessageModel>? messages;
  String trainer;
  String client;

  ChatConversationModel({
    this.id,
    this.messages,
    required this.trainer,
    required this.client,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'messages': messages?.map((x) => x.toMap()).toList(),
      'trainer': trainer,
      'client': client,
    };
  }

  factory ChatConversationModel.fromMap(Map<String, dynamic> map, String? id) {
    return ChatConversationModel(
      id: id,
      messages: map['messages'] != null
          ? List<MessageModel>.from(
              map['messages']?.map((x) => MessageModel.fromMap(x)))
          : null,
      trainer: map['trainer'],
      client: map['client'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatConversationModel.fromJson(String source, String? id) =>
      ChatConversationModel.fromMap(json.decode(source), id);
}