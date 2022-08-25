import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/buttons/standart_button.dart';
import 'package:tcc_app/widgets/buttons/standart_outlined_button.dart';

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
    required String title,
    required String description,
    Function? button1,
    String? textButton1,
    bool button1IsOutline = false,
    Function? button2,
    String? textButton2,
    bool button2IsOutline = false,
    Function? button3,
    String? textButton3,
    bool button3IsOutline = false,
  }) {
    Get.defaultDialog(
      barrierDismissible: false,
      title: title,
      titlePadding: const EdgeInsets.symmetric(vertical: 8),
      titleStyle: GoogleFonts.poppins(
        color: CustomColors.primaryColor,
      ),
      backgroundColor: CustomColors.whiteStandard,
      radius: 10,
      content: Column(
        children: [
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: CustomColors.primaryColor,
              fontSize: 16,
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
                        ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
