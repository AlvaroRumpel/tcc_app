import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/config/database_variables.dart';
import 'package:tcc_app/models/user_model.dart';
import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/services/user_service.dart';
import 'package:tcc_app/utils/utils_widgets.dart';
import 'package:tcc_app/utils/validators.dart';

class SingupClientFormController extends GetxController with StateMixin<int> {
  SingupClientFormController({Key? key});
  int currentStep = 0;
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
    super.onInit();
    await getObjectives();
    change(currentStep, status: RxStatus.success());
  }

  Future<void> getObjectives() async {
    try {
      var response = await db.collection(DB.goals).get();
      for (var res in response.docs) {
        objectives.add(res.data()['goal']);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void next() {
    if (currentStep == 0) {
      currentStep++;
    } else if (currentStep == 1 && !validator.hasErroSecondaryData()) {
      singUp();
    } else {
      UtilsWidgets.errorSnackbar(title: 'Existe algum erro ainda');
    }
    change(currentStep, status: RxStatus.success());
  }

  void back() {
    if (currentStep > 0) {
      currentStep--;
    } else {
      Get.back();
    }
    change(currentStep, status: RxStatus.success());
  }

  void singUp() async {
    try {
      UtilsWidgets.loadingDialog();
      UserService.singup(
        userModel: UserModel(
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
          trainers: [],
        ),
      );

      Get.offAndToNamed(Routes.toHomeClient);
      Get.deleteAll();
    } on FirebaseAuthException catch (e) {
      UtilsWidgets.errorSnackbar(
        description: e.message.toString(),
      );
    }
  }
}
