import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/utils/utils_widgets.dart';
import 'package:tcc_app/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SingupController extends GetxController {
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Validators validator = Validators();

  Future<void> singup() async {
    if (validator.hasError(withUser: true) ||
        validator.isEmpty(emailController.text, passController.text,
            user: userController.text)) {
      UtilsWidgets.errorSnackbar(title: 'Preencha os dados corretamente');
      return;
    }
    try {
      UtilsWidgets.loadingDialog();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: GetUtils.removeAllWhitespace(passController.text));
      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(userController.text);
      Get.back();
      UtilsWidgets.sucessSnackbar(
          title: 'Cadastro realizado com sucesso',
          description: 'Obrigado pelo cadastro!');
    } on FirebaseAuthException catch (e) {
      Get.back();
      UtilsWidgets.errorSnackbar(description: e.message.toString());
    }
  }
}
