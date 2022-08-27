import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tcc_app/config/database_variables.dart';
import 'package:tcc_app/global/global_controller.dart';
import 'package:tcc_app/models/trainer_model.dart';
import 'package:tcc_app/models/trainer_user_model.dart';
import 'package:tcc_app/models/user_model.dart';
import 'package:tcc_app/utils/utils_widgets.dart';
import 'package:tcc_app/widgets/trainer_modal.dart';

class ProfileController extends GetxController with StateMixin<UserModel> {
  ProfileController({Key? key});
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TrainerModel? trainerComplete;
  UserModel? profile;
  GlobalController globalController = GlobalController.i;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData({bool isRefresh = false}) async {
    change(state, status: RxStatus.loading());
    if (isRefresh) {
      await globalController.getClient();
    }
    profile = globalController.client;
    trainerComplete = globalController.trainer;

    change(profile ?? state,
        status: profile != null ? RxStatus.success() : RxStatus.empty());

    if (profile != null) return;
    UtilsWidgets.errorScreen();
    UtilsWidgets.errorSnackbar(title: 'Usuario não encontrado');
  }

  void openTrainerModal() {
    TrainerModal.defaultTrainerModal(
      trainerComplete!,
      dismissTrainer: true,
    );
  }
}
