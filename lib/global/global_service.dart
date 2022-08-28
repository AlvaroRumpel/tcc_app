import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:tcc_app/config/database_variables.dart';
import 'package:tcc_app/models/trainer_model.dart';
import 'package:tcc_app/models/training_finished_model.dart';
import 'package:tcc_app/models/user_model.dart';

class GlobalService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<UserModel?> getClient({String? idClient}) async {
    try {
      var response = await db
          .collection(DB.clients)
          .where('client_id',
              isEqualTo: idClient ?? FirebaseAuth.instance.currentUser?.uid)
          .get();
      for (var res in response.docs) {
        return UserModel.fromMap(res.data(), res.id);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<TrainerModel?> getTrainer({String? idTrainer}) async {
    try {
      var response = await db
          .collection(DB.trainers)
          .where('trainer_id',
              isEqualTo: idTrainer ?? FirebaseAuth.instance.currentUser?.uid)
          .get();
      for (var res in response.docs) {
        return TrainerModel.fromMap(res.data(), res.id);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<List<TrainingFinishedModel>?> getHistory() async {
    List<TrainingFinishedModel> historic = [];
    try {
      var response = await db
          .collection(DB.historic)
          .where(
            'client_id',
            isEqualTo: FirebaseAuth.instance.currentUser?.uid ?? '',
          )
          .orderBy('date', descending: false)
          .get();
      if (response.docs.isEmpty) {
        return null;
      }
      for (var item in response.docs) {
        historic.add(TrainingFinishedModel.fromMap(item.data(), item.id));
      }
      return historic;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
