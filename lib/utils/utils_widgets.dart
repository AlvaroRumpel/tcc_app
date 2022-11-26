import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_workout/routes/routes.dart';
import 'package:play_workout/services/local_storage.dart';
import 'package:play_workout/utils/custom_colors.dart';
import 'package:play_workout/widgets/buttons/standart_button.dart';
import 'package:play_workout/widgets/buttons/standart_outlined_button.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilsWidgets {
  UtilsWidgets.loadingDialog({String title = 'Loading...'}) {
    Get.defaultDialog(
      barrierDismissible: false,
      title: title,
      titlePadding: const EdgeInsets.symmetric(vertical: 32),
      titleStyle: GoogleFonts.poppins(
        color: CustomColors.primaryColor,
      ),
      backgroundColor: CustomColors.whiteStandard,
      radius: 10,
      content: const CircularProgressIndicator(),
    );
  }

  UtilsWidgets.errorSnackbar(
      {String title = 'Erro...',
      String description = 'Por favor verifique as informações'}) {
    Get.snackbar(
      title,
      description,
      titleText: Text(
        title,
        style: GoogleFonts.poppins(
          color: CustomColors.whiteStandard,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      messageText: Text(
        description,
        style: GoogleFonts.poppins(
          color: CustomColors.whiteStandard,
        ),
        textAlign: TextAlign.center,
      ),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      colorText: CustomColors.whiteStandard,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: CustomColors.errorColor,
      borderRadius: 20,
    );
  }

  UtilsWidgets.sucessSnackbar(
      {String title = 'Sucesso...',
      String description = 'Operação feita com sucesso'}) {
    Get.snackbar(
      title,
      description,
      titleText: Text(
        title,
        style: GoogleFonts.poppins(
          color: CustomColors.whiteStandard,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      messageText: Text(
        description,
        style: GoogleFonts.poppins(
          color: CustomColors.whiteStandard,
        ),
        textAlign: TextAlign.center,
      ),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      colorText: CustomColors.whiteStandard,
      snackPosition: SnackPosition.TOP,
      backgroundColor: CustomColors.sucessColor,
      borderRadius: 20,
    );
  }

  UtilsWidgets.errorScreen(
      {String message = 'Erro na operação',
      IconData icon = FontAwesome.attention}) {
    Get.defaultDialog(
      title: message,
      titlePadding: const EdgeInsets.symmetric(vertical: 8),
      titleStyle: GoogleFonts.poppins(
        color: CustomColors.primaryColor,
      ),
      backgroundColor: CustomColors.whiteStandard,
      radius: 10,
      content: SingleChildScrollView(
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: CustomColors.primaryColor,
            ),
            StandartButton(
              text: 'Voltar para a tela inicial',
              function: () => Get.offAndToNamed(Routes.toHomeClient),
            ),
          ],
        ),
      ),
    );
  }

  UtilsWidgets.buttonsDialog({
    bool isDimissible = false,
    required String title,
    required String description,
    Function? button1,
    String? textButton1,
    bool button1IsOutline = false,
    Color? button1Color,
    Function? button2,
    String? textButton2,
    bool button2IsOutline = false,
    Color? button2Color,
    Function? button3,
    String? textButton3,
    bool button3IsOutline = false,
    Color? button3Color,
  }) {
    Get.defaultDialog(
      barrierDismissible: isDimissible,
      title: title,
      titlePadding: const EdgeInsets.symmetric(vertical: 8),
      titleStyle: GoogleFonts.poppins(
        color: CustomColors.primaryColor,
      ),
      backgroundColor: CustomColors.whiteStandard,
      radius: 10,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: CustomColors.primaryColor,
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              children: [
                if (button1 != null && textButton1 != null)
                  Expanded(
                    flex: 3,
                    child: button1IsOutline
                        ? StandartOutlinedButton(
                            text: textButton1,
                            function: button1,
                            smallText: true,
                            dense: true,
                          )
                        : StandartButton(
                            text: textButton1,
                            dense: true,
                            function: button1,
                            smallText: true,
                            color: button1Color ?? CustomColors.primaryColor,
                          ),
                  ),
                if (button1 != null && textButton1 != null)
                  const Expanded(
                    flex: 1,
                    child: Divider(),
                  ),
                if (button2 != null && textButton2 != null)
                  Expanded(
                    flex: 3,
                    child: button2IsOutline
                        ? StandartOutlinedButton(
                            text: textButton2,
                            dense: true,
                            function: button2,
                            smallText: true,
                          )
                        : StandartButton(
                            text: textButton2,
                            dense: true,
                            function: button2,
                            smallText: true,
                            color: button2Color ?? CustomColors.primaryColor,
                          ),
                  ),
                if (button3 != null && textButton2 != null)
                  const Expanded(
                    flex: 1,
                    child: Divider(),
                  ),
                if (button3 != null && textButton3 != null)
                  Expanded(
                    flex: 3,
                    child: button3IsOutline
                        ? StandartOutlinedButton(
                            text: textButton3,
                            dense: true,
                            function: button3,
                            smallText: true,
                          )
                        : StandartButton(
                            text: textButton3,
                            dense: true,
                            function: button3,
                            smallText: true,
                            color: button3Color ?? CustomColors.primaryColor,
                          ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  UtilsWidgets.levelUpModal(int nivel, Function onWillPop) {
    Get.defaultDialog(
      onWillPop: onWillPop(),
      barrierDismissible: true,
      title: 'Parabéns você subiu de nível',
      titlePadding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16.0),
      titleStyle: GoogleFonts.poppins(
        color: CustomColors.primaryColor,
        fontSize: 24,
      ),
      backgroundColor: CustomColors.whiteStandard,
      radius: 10,
      middleText: 'Você evoluiu, agora está no nível $nivel',
      middleTextStyle: GoogleFonts.poppins(
        color: CustomColors.primaryColor,
        fontSize: 16,
      ),
    );
  }

  UtilsWidgets.emailVerifiedSnackbar(Function sendEmailFunction) {
    Get.snackbar(
      'Verifique seu email!',
      'Seu email não está verificado, por favor acesse seu email e confirme sua identidade',
      backgroundColor: CustomColors.primaryColor,
      titleText: Text(
        'Verifique seu email!',
        style: GoogleFonts.poppins(
          color: CustomColors.whiteStandard,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      messageText: Column(
        children: [
          Text(
            'Seu email não está verificado, por favor acesse seu email e confirme sua identidade',
            style: GoogleFonts.poppins(
              color: CustomColors.whiteStandard,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: StandartButton(
              text: 'Enviar outro email',
              function: sendEmailFunction,
              dense: true,
              color: CustomColors.whiteTertiary,
              finalIcon: Icons.mark_email_unread_outlined,
              textColor: CustomColors.primaryColor,
            ),
          ),
        ],
      ),
      borderRadius: 20,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 10),
    );
  }

  UtilsWidgets.termsModal(
    Function() onClickAccept,
  ) {
    Get.defaultDialog(
      barrierDismissible: true,
      title: 'Termos de uso',
      titlePadding: const EdgeInsets.only(top: 8),
      titleStyle: GoogleFonts.poppins(
        color: CustomColors.primaryColor,
        fontSize: 24,
      ),
      backgroundColor: CustomColors.whiteStandard,
      radius: 10,
      content: Column(
        children: [
          StandartOutlinedButton(
            text: 'ler os termos',
            function: () async {
              var uri = Uri.parse(
                  'https://pages.flycricket.io/play-workout-0/terms.html');
              if (!await launchUrl(uri)) {
                throw 'Erro';
              }
            },
          ),
          StandartButton(
            text: 'Aceitar termos',
            smallText: true,
            function: () async {
              await LocalStorage.setTermsAccepted(true);
              Get.back();
              onClickAccept();
            },
          ),
        ],
      ),
    );
  }
}
