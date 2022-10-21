import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:play_workout/config/database_variables.dart';
import 'package:play_workout/models/workouts_model.dart';

class TrainingClientAllListService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<WorkoutsModel>> getWorkoutList({
    required String clientId,
    required String trainerId,
  }) async {
    List<WorkoutsModel> workouts = [];
    try {
      var response = await db
          .collection(DB.workouts)
          .where(
            'client_id',
            isEqualTo: clientId,
          )
          .where(
            'trainer_id',
            isEqualTo: trainerId,
          )
          .get();

      if (response.docs.isEmpty) {
        return workouts;
      }

      for (var item in response.docs) {
        workouts.add(WorkoutsModel.fromMap(item.data(), item.id, true));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return workouts;
  }
}
