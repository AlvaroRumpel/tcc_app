import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/buttons/standart_button.dart';

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
}
