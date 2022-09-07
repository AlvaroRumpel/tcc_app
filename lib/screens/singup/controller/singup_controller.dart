import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_workout/routes/routes.dart';
import 'package:play_workout/services/local_storage.dart';
import 'package:play_workout/utils/utils_widgets.dart';
import 'package:play_workout/utils/validators.dart';

class SingupController extends GetxController {
  SingupController({Key? key});
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Validators validator = Validators();

  Future<void> singup({isPersonal = false}) async {
    if (validator.hasError(withUser: true) ||
        validator.isEmpty(
          emailController.text,
          passController.text,
          user: userController.text,
        )) {
      UtilsWidgets.errorSnackbar(title: 'Preencha os dados corretamente');
      return;
    }
    try {
      UtilsWidgets.loadingDialog();
      LocalStorage.setUserName(userController.text);
      LocalStorage.setPassword(passController.text);
      LocalStorage.setEmail(emailController.text);
      Get.back();
      UtilsWidgets.sucessSnackbar(
          title: 'Obrigado pelo acesso!',
          description: 'Por favor preencha os campos com suas informações');

      if (!isPersonal) {
        Get.toNamed(Routes.toClientSingUp);
      } else {
        Get.toNamed(Routes.toTrainerSingUp);
      }
    } catch (e) {
      Get.back();
      UtilsWidgets.errorSnackbar(description: e.toString());
    }
  }
}
