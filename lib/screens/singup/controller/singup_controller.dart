import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/utils/utils_widgets.dart';
import 'package:tcc_app/utils/validators.dart';

class SingupController extends GetxController {
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Validators validator = Validators();

  Future<void> singup({isPersonal = false}) async {
    if (validator.hasError(withUser: true) ||
        validator.isEmpty(emailController.text, passController.text,
            user: userController.text)) {
      UtilsWidgets.errorSnackbar(title: 'Preencha os dados corretamente');
      return;
    }
    try {
      SharedPreferences user = await SharedPreferences.getInstance();
      UtilsWidgets.loadingDialog();
      user.setString('userName', userController.text);
      user.setString(
          'password', GetUtils.removeAllWhitespace(passController.text));
      user.setString('email', emailController.text);
      Get.back();
      UtilsWidgets.sucessSnackbar(
          title: 'Cadastro realizado com sucesso',
          description: 'Obrigado pelo cadastro!');

      if (!isPersonal) {
        Get.toNamed(Routes.toClientSingUp);
      } else {
        Get.toNamed(Routes.toPersonalSingUp);
      }
    } catch (e) {
      Get.back();
      UtilsWidgets.errorSnackbar(description: e.toString());
    }
  }
}
