import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_app/config/database_variables.dart';
import 'package:tcc_app/models/user_model.dart';
import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/utils/utils_widgets.dart';
import 'package:tcc_app/utils/validators.dart';

class SingupClientFormController extends GetxController {
  RxInt currentStep = 0.obs;
  Validators validator = Validators();
  RxInt radioValue = 1.obs;

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bodyFatController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;
  List<String> objectives = [];
  DropdownEditingController<String> objectiveController =
      DropdownEditingController();
  @override
  void onInit() async {
    getObjectives();
    super.onInit();
  }

  void getObjectives() async {
    try {
      var response = await db.collection(DB.goals).get();
      for (var res in response.docs) {
        objectives.add(res.data()['goal']);
      }
    } catch (e) {
      print(e);
    }
  }

  void next() {
    if (currentStep.value == 0) {
      currentStep.value++;
    } else if (currentStep.value == 1 && !validator.hasErroSecondaryData()) {
      singUp();
    } else {
      UtilsWidgets.errorSnackbar(title: 'Existe algum erro ainda');
    }
  }

  void singUp() async {
    try {
      UtilsWidgets.loadingDialog();
      SharedPreferences user = await SharedPreferences.getInstance();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.getString('email') ?? '',
        password: user.getString('password') ?? '',
      );
      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(user.getString('userName'));

      UserModel newUser = UserModel(
        clientId: FirebaseAuth.instance.currentUser?.uid ?? '',
        name: FirebaseAuth.instance.currentUser?.displayName ?? '',
        bodyFat: int.parse(bodyFatController.text),
        goal: objectiveController.value.toString(),
        height: int.parse(heightController.text),
        weight: int.parse(weightController.text),
        level: 0,
        xp: 0,
        sex: radioValue.value,
        birthDate: dateController.text,
      );
      db.collection('clients').add(newUser.toMap());
      user.setBool('clients', true);
      Get.offAndToNamed(Routes.toHomeClient);
    } on FirebaseAuthException catch (e) {
      UtilsWidgets.errorSnackbar(description: e.message.toString());
    }
  }
}
