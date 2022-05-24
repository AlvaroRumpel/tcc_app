import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_app/config/commom_config.dart';
import 'package:tcc_app/config/database_variables.dart';

class UserService {
  static Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: GetUtils.removeAllWhitespace(password),
      );
      return checkIsClient();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(message: e.message, code: e.code);
    }
  }

  static Future<String> checkIsClient() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    try {
      await FirebaseFirestore.instance
          .collection(DB.clients)
          .where('client_id',
              isEqualTo: FirebaseAuth.instance.currentUser?.uid ?? '')
          .get();
      await user.setBool(CommomConfig.isClient, true);
      return 'isClient';
    } catch (e) {
      await user.setBool(CommomConfig.isClient, false);
      return 'isPersonal';
    }
  }
}
