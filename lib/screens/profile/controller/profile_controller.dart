import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tcc_app/config/database_variables.dart';
import 'package:tcc_app/models/user_model.dart';
import 'package:tcc_app/utils/utils_widgets.dart';

class ProfileController extends GetxController with StateMixin<UserModel> {
  ProfileController({Key? key});
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    change(state, status: RxStatus.loading());
    getData();
  }

  void getData() async {
    try {
      UserModel? profile;
      var response = await db
          .collection(DB.clients)
          .where('client_id', isEqualTo: user!.uid)
          .get();
      for (var res in response.docs) {
        profile = UserModel.fromMap(res.data(), res.id);
      }
      change(profile, status: RxStatus.success());
    } catch (e) {
      UtilsWidgets.errorScreen();
      Logger().d(e);
      change(state, status: RxStatus.empty());
      UtilsWidgets.errorSnackbar(title: 'Usuario não encontrado');
    }
  }
}
