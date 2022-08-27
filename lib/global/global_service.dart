import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_app/config/database_variables.dart';
import 'package:tcc_app/models/trainer_model.dart';
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
}
