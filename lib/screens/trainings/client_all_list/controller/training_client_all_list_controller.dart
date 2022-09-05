import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tcc_app/config/database_variables.dart';
import 'package:tcc_app/global/global_controller.dart';
import 'package:tcc_app/models/workouts_model.dart';
import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/screens/contract_trainer/controller/contract_trainer_controller.dart';

class TrainingClientAllListController extends GetxController
    with StateMixin<List<WorkoutsModel>> {
  TrainingClientAllListController({Key? key});
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<WorkoutsModel> workouts = [];
  GlobalController globalController = GlobalController.i;

  static TrainingClientAllListController get i => Get.find();

  @override
  void onInit() {
    super.onInit();
    change(state, status: RxStatus.loading());
    getData();
  }

  Future<void> getData() async {
    workouts.clear();
    try {
      while (ContractTrainerController.i.trainers.isEmpty) {
        await Future.delayed(const Duration(seconds: 2));
      }
      var response = await db
          .collection(DB.workouts)
          .where(
            'client_id',
            isEqualTo: FirebaseAuth.instance.currentUser?.uid,
          )
          .where(
            'trainer_id',
            isEqualTo: globalController.trainer?.trainerId,
          )
          .get();

      if (response.docs.isEmpty) {
        change(workouts, status: RxStatus.empty());
        return;
      }

      for (var item in response.docs) {
        workouts.add(WorkoutsModel.fromMap(item.data(), item.id, true));
      }
      change(workouts, status: RxStatus.success());
    } catch (e) {
      Logger().d(e);
      change(workouts, status: RxStatus.empty());
    }
  }

  void goToTraining(int index) {
    Get.toNamed(
      Routes.toTrainingClientOne,
      arguments: workouts[index].trainings,
    );
  }
}
