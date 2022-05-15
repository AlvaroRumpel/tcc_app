import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/utils/validators.dart';

class SingupClientFormController extends GetxController {
  RxInt currentStep = 0.obs;
  Validators validator = Validators();
  RxInt radioValue = 1.obs;

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bodyFatController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  List<String> objectivos = [
    'Quero emagrecer',
    'Quero ganhar massa muscular',
    'Quero condicionamento físico',
    'Quero bem-estar e saúde'
  ];

  void next() {
    if (currentStep.value == 0 && !validator.hasErroSecondaryData()) {
      currentStep.value++;
    } else {
      Get.offAndToNamed('/home');
    }
  }
}
