import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_workout/config/database_variables.dart';
import 'package:play_workout/models/user_model.dart';
import 'package:play_workout/routes/routes.dart';
import 'package:play_workout/services/user_service.dart';
import 'package:play_workout/utils/utils_widgets.dart';
import 'package:play_workout/utils/validators.dart';

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
    if (!validator.hasError.success) {
      UtilsWidgets.errorSnackbar(
          title: 'Existe erro no campo ${validator.hasError.message}');
      return;
    }
    if (currentStep == 0) {
      currentStep++;
    } else if (currentStep == 1 && validator.hasError.success) {
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

  void singUp() async {
    try {
      UtilsWidgets.loadingDialog();
      await UserService.singup(
        userModel: UserModel(
          clientId: FirebaseAuth.instance.currentUser?.uid ?? '',
          name: FirebaseAuth.instance.currentUser?.displayName ?? '',
          bodyFat: bodyFatController.text == ''
              ? 0
              : int.parse(bodyFatController.text),
          goal: objectiveController.value.toString(),
          height: int.parse(heightController.text),
          weight: int.parse(weightController.text),
          level: 0,
          xp: 0,
          sex: radioValue.value,
          birthDate: dateController.text,
          trainers: [],
          termsAccepted: true,
        ),
      );

      Get.offAllNamed(Routes.toHomeClient);
    } on FirebaseAuthException catch (e) {
      Get.back();
      UtilsWidgets.errorSnackbar(description: e.message.toString());
    } catch (e) {
      Get.back();
      UtilsWidgets.errorSnackbar(description: e.toString());
    }
  }
}
