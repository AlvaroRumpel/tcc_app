import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_cep/search_cep.dart';
import 'package:play_workout/models/trainer_model.dart';
import 'package:play_workout/routes/routes.dart';
import 'package:play_workout/services/user_service.dart';
import 'package:play_workout/utils/utils_widgets.dart';
import 'package:play_workout/utils/validators.dart';

class SingupTrainerFormController extends GetxController with StateMixin<int> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController keyController = TextEditingController();
  int currentStep = 0;
  Validators validator = Validators();
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    change(currentStep, status: RxStatus.success());
  }

  void next() async {
    if (!validator.hasError.success) {
      UtilsWidgets.errorSnackbar(
          title: 'Existe erro no campo ${validator.hasError.message}');
      return;
    }
    if (currentStep < 2) {
      currentStep++;
      validator.resetValidator();
    } else if (currentStep == 2 && validator.hasError.success) {
      singUp();
    }
    change(currentStep, status: RxStatus.success());
  }

  void back() {
    if (currentStep > 0) {
      currentStep--;
      validator.resetToAllClear();
    } else {
      Get.back();
      return;
    }
    change(currentStep, status: RxStatus.success());
  }

  Future<bool> checkCep() async {
    final cepExist =
        await ViaCepSearchCep().searchInfoByCep(cep: cepController.text);
    if (cepExist.isLeft()) {
      UtilsWidgets.errorSnackbar(title: 'CEP não existe');
      return false;
    }
    return true;
  }

  void singUp() async {
    UtilsWidgets.loadingDialog();
    if (!await checkCep()) return;
    try {
      await UserService.singup(
        trainerModel: TrainerModel(
          trainerId: FirebaseAuth.instance.currentUser?.uid ?? '',
          firstName: nameController.text,
          lastName: lastNameController.text,
          price: priceValue(priceController.text),
          phone: int.parse(phoneController.text),
          cpf: cpfController.text,
          cep: int.parse(cepController.text),
          about: aboutController.text,
          paymentKey: keyController.text,
          rating: 0.0,
          numberClients: 0,
          clients: [],
        ),
      );
      Get.offAllNamed(Routes.toHomeTrainer);
      Get.deleteAll();
    } on FirebaseAuthException catch (e) {
      Get.closeAllSnackbars();
      UtilsWidgets.errorSnackbar(description: e.message.toString());
      return;
    }
  }

  double priceValue(String value) {
    if (value.contains(',')) {
      return double.parse('${value.split(',')[0]}.${value.split(',')[1]}');
    }
    return double.parse(value);
  }
}
