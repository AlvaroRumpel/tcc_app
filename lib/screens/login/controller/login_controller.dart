import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/services/user_service.dart';
import 'package:tcc_app/utils/utils_widgets.dart';
import 'package:tcc_app/utils/validators.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Validators validator = Validators();
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> login() async {
    if (validator.hasError() ||
        validator.isEmpty(emailController.text, passController.text)) {
      UtilsWidgets.errorSnackbar();
      return;
    }
    try {
      UtilsWidgets.loadingDialog();

      var typeOfUser =
          await UserService.login(emailController.text, passController.text);

      Get.back();
      UtilsWidgets.sucessSnackbar(title: 'Login realizado');

      if (typeOfUser != 'isClient') {
        Routes.offToHomePersonal;
      } else {
        Routes.offToHomeClient;
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      UtilsWidgets.errorSnackbar(description: e.message.toString());
    }
  }
}
