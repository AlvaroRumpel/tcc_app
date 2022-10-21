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
    if (!validator.hasError.success ||
        validator.isEmpty(
          emailController.text,
          passController.text,
          user: userController.text,
        )) {
      UtilsWidgets.errorSnackbar(title: 'Preencha os dados corretamente');
      return;
    }
    UtilsWidgets.termsModal(
      () async => await toSingUpForms(isPersonal: isPersonal),
    );
  }

  Future<void> toSingUpForms({isPersonal = false}) async {
    try {
      UtilsWidgets.loadingDialog();
      await LocalStorage.setUserName(userController.text);
      await LocalStorage.setPassword(passController.text);
      await LocalStorage.setEmail(emailController.text);
      Get.back();
      UtilsWidgets.sucessSnackbar(
        title: 'Obrigado pelo acesso!',
        description: 'Por favor preencha os campos com suas informações',
      );

      if (!isPersonal) {
        await Get.toNamed(Routes.toClientSingUp);
      } else {
        await Get.toNamed(Routes.toTrainerSingUp);
      }
    } catch (e) {
      Get.back();
      UtilsWidgets.errorSnackbar(description: e.toString());
    }
  }
}
