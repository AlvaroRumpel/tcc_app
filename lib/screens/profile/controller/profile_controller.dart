import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tcc_app/config/database_variables.dart';
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

  @override
  void onInit() {
    super.onInit();
    change(state, status: RxStatus.loading());
    getData();
  }

  void getData() async {
    try {
      TrainerUserModel? trainer;
      UserModel? profile;
      var response = await db
          .collection(DB.clients)
          .where('client_id', isEqualTo: user!.uid)
          .get();

      if (response.docs.isEmpty) {
        change(state, status: RxStatus.empty());
      }
      for (var res in response.docs) {
        profile = UserModel.fromMap(res.data(), res.id);
      }
      trainer =
          profile!.trainers.firstWhereOrNull((e) => e.active && e.accepted);
      if (trainer != null) {
        var trainerResponse = await db
            .collection(DB.trainers)
            .where('trainer_id', isEqualTo: trainer.trainerId)
            .get();
        for (var item in trainerResponse.docs) {
          trainerComplete = TrainerModel.fromMap(item.data(), item.id);
        }
      }
      change(profile, status: RxStatus.success());
    } catch (e) {
      UtilsWidgets.errorScreen();
      Logger().d(e);
      change(state, status: RxStatus.empty());
      UtilsWidgets.errorSnackbar(title: 'Usuario não encontrado');
    }
  }

  void openTrainerModal() {
    TrainerModal.defaultTrainerModal(
      trainerComplete!,
      dismissTrainer: true,
    );
  }
}
