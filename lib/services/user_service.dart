import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tcc_app/config/database_variables.dart';
import 'package:tcc_app/models/enum/user_type.dart';
import 'package:tcc_app/models/trainer_model.dart';
import 'package:tcc_app/models/user_model.dart';
import 'package:tcc_app/services/local_storage.dart';

class UserService {
  static Future<UserType> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: GetUtils.removeAllWhitespace(password),
      );
      return checkIsClient();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        message: e.message,
        code: e.code,
      );
    }
  }

  static Future<UserType> checkIsClient() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection(DB.clients)
          .where('client_id',
              isEqualTo: FirebaseAuth.instance.currentUser?.uid ?? '')
          .get();
      if (response.docs.isNotEmpty) {
        await LocalStorage.setIsClients(true);
        return UserType.client;
      }
      await LocalStorage.setIsClients(false);
      return UserType.trainer;
    } catch (e) {
      await LocalStorage.setIsClients(false);
      return UserType.trainer;
    }
  }

  static Future<void> singup({
    TrainerModel? trainerModel,
    UserModel? userModel,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: await LocalStorage.getEmail(),
        password: await LocalStorage.getPassword(),
      );
      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(await LocalStorage.getUserName());
      if (trainerModel != null) {
        await FirebaseFirestore.instance
            .collection(DB.trainers)
            .add(trainerModel.toMap());
        LocalStorage.setIsClients(false);
      } else if (userModel != null) {
        await FirebaseFirestore.instance
            .collection(DB.clients)
            .add(userModel.toMap());
        LocalStorage.setIsClients(true);
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        message: e.message,
        code: e.code,
      );
    }
  }
}
