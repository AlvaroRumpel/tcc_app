import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/utils/utils_widgets.dart';
import 'package:tcc_app/utils/validators.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Validators validator = Validators();

  Future<void> login() async {
    if (validator.hasError() ||
        validator.isEmpty(emailController.text, passController.text)) {
      UtilsWidgets.errorSnackbar();
      return;
    }
    try {
      UtilsWidgets.loadingDialog();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: GetUtils.removeAllWhitespace(passController.text),
      );
      Get.back();
      UtilsWidgets.sucessSnackbar(title: 'Login realizado');
      Get.offAndToNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.back();
      UtilsWidgets.errorSnackbar(description: e.message.toString());
    }
  }
}
