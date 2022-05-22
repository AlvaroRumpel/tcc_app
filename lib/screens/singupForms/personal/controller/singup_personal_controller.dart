import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_cep/search_cep.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_app/utils/utils_widgets.dart';
import 'package:tcc_app/utils/validators.dart';

class SingupPersonalFormController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController sobrenomeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController keyController = TextEditingController();
  RxInt currentStep = 0.obs;
  Validators validator = Validators();
  FirebaseFirestore db = FirebaseFirestore.instance;

  void next() async {
    if (currentStep.value < 2) {
      currentStep.value++;
    } else if (currentStep.value == 2 &&
        validator.hasErrorPersonalValidation()) {
      singUp();
    } else {
      UtilsWidgets.errorSnackbar(title: 'Existe algum erro ainda');
    }
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
    if (!await checkCep()) return;
    try {
      UtilsWidgets.loadingDialog();
      SharedPreferences user = await SharedPreferences.getInstance();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.getString('email') ?? '',
        password: user.getString('password') ?? '',
      );
      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(user.getString('userName'));
      db.collection('treiners').add({
        'personal_id': FirebaseAuth.instance.currentUser?.uid,
        'name': nameController.text,
        'last_name': sobrenomeController.text,
        'price': priceController.text,
        'phone': phoneController.text,
        'cpf': cpfController.text,
        'cep': cepController.text,
        'about': aboutController.text,
        'paymant_key': keyController.text,
        'rating': 0,
      });
      Get.offAndToNamed('/home');
    } on FirebaseAuthException catch (e) {
      UtilsWidgets.errorSnackbar(description: e.message.toString());
      return;
    }
  }
}
