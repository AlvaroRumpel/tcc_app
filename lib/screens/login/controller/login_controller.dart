import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/models/enum/user_type.dart';
import 'package:play_workout/routes/routes.dart';
import 'package:play_workout/services/user_service.dart';
import 'package:play_workout/utils/custom_colors.dart';
import 'package:play_workout/utils/utils_widgets.dart';
import 'package:play_workout/utils/validators.dart';
import 'package:play_workout/widgets/buttons/standart_button.dart';
import 'package:play_workout/widgets/standart_textfield.dart';
import 'package:play_workout/widgets/texts/standart_text.dart';

class LoginController extends GetxController {
  LoginController({Key? key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Validators validator = Validators();
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> login() async {
    if (!validator.hasError.success ||
        validator.isEmpty(emailController.text, passController.text)) {
      UtilsWidgets.errorSnackbar();
      return;
    }
    try {
      UtilsWidgets.loadingDialog();

      UserType typeOfUser =
          await UserService.login(emailController.text, passController.text);

      Get.offAllNamed(
        typeOfUser == UserType.client
            ? Routes.toHomeClient
            : Routes.toHomeTrainer,
      );

      GlobalController.i.isEmailVerified();
    } on FirebaseAuthException catch (e) {
      Get.back();
      UtilsWidgets.errorSnackbar(description: e.message.toString());
    }
  }

  void forgotPass() {
    TextEditingController emailForgotPassController = TextEditingController();

    Get.defaultDialog(
      title: 'Insira seu email',
      titlePadding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      titleStyle: GoogleFonts.poppins(
        color: CustomColors.primaryColor,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: StandartText(
              text: 'Será enviado um email para a redefinição de senha',
              isLabel: true,
              align: TextAlign.center,
            ),
          ),
          StandartTextfield(
            controller: emailForgotPassController,
            labelText: 'Email',
            validator: validator.emailValidator,
            errorText: 'Email inválido',
            fit: true,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: StandartButton(
              finalIcon: Icons.lock_outline,
              text: 'Enviar',
              function: () async =>
                  await sendEmailForgotPass(emailForgotPassController.text),
              dense: true,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendEmailForgotPass(String email) async {
    if (email.isEmpty && !email.isEmail) {
      UtilsWidgets.errorSnackbar();
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      UtilsWidgets.sucessSnackbar(description: 'Email enviado para $email');
    } on FirebaseAuthException catch (e) {
      UtilsWidgets.errorSnackbar(description: e.message ?? '');
    }
  }
}
