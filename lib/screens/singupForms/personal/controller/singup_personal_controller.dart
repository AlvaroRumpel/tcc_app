import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/utils/utils_widgets.dart';
import 'package:tcc_app/utils/validators.dart';

class SingupPersonalFormController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController keyController = TextEditingController();
  RxInt currentStep = 0.obs;
  Validators validator = Validators();

  void next() {
    if (currentStep.value == 0) {
      currentStep.value++;
    } else if (currentStep.value == 1 && !validator.hasErroSecondaryData()) {
      // singUp();
    } else {
      UtilsWidgets.errorSnackbar(title: 'Existe algum erro ainda');
    }
  }
}
