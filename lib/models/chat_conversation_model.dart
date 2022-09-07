import 'dart:convert';
import 'package:play_workout/models/message_model.dart';

class ChatConversationModel {
  String? id;
  List<MessageModel>? messages;
  String trainer;
  String client;
  String? clientFcmToken;
  String? trainerFcmToken;

  ChatConversationModel({
    this.id,
    this.messages,
    required this.trainer,
    required this.client,
    this.clientFcmToken,
    this.trainerFcmToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'messages': messages?.map((x) => x.toMap()).toList(),
      'trainer': trainer,
      'client': client,
      'client_fcm_token': clientFcmToken,
      'trainer_fcm_token': trainerFcmToken,
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
      clientFcmToken: map['client_fcm_token'],
      trainerFcmToken: map['trainer_fcm_token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatConversationModel.fromJson(String source, String? id) =>
      ChatConversationModel.fromMap(json.decode(source), id);
}
