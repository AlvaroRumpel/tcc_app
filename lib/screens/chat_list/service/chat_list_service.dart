import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:play_workout/config/database_variables.dart';
import 'package:play_workout/models/chat_conversation_model.dart';
import 'package:play_workout/services/local_storage.dart';

class ChatListService {
  var db = FirebaseFirestore.instance;
  var userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<List<ChatConversationModel>> getConversations() async {
    List<ChatConversationModel> conversations = [];
    try {
      var isClient = await LocalStorage.getIsClients();
      var response = await db
          .collection(DB.conversation)
          .where(
            isClient ? 'client' : 'trainer',
            isEqualTo: userId,
          )
          .get();

      if (response.docs.isEmpty) {
        return conversations;
      }

      for (var item in response.docs) {
        conversations.add(ChatConversationModel.fromMap(item.data(), item.id));
      }
      return conversations;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return conversations;
    }
  }

  Future<List> getPeople(List<String> peopleIds) async {
    List people = [];
    try {
      var isClient = await LocalStorage.getIsClients();
      var response = await db
          .collection(isClient ? DB.trainers : DB.clients)
          .where(isClient ? 'trainer_id' : 'client_id', whereIn: peopleIds)
          .get();

      if (response.docs.isEmpty) {
        return people;
      }

      for (var item in response.docs) {
        people.add(item.data());
      }
      return people;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return people;
    }
  }
}
