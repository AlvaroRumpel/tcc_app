import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tcc_app/models/trainer_model.dart';
import 'package:tcc_app/models/training_model.dart';
import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/screens/contract_trainer/controller/contract_trainer_controller.dart';

class TrainingClientAllListController extends GetxController
    with StateMixin<TrainerModel> {
  TrainingClientAllListController({Key? key});
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxList<String> trainings = ['a', 'b', 'c', 'd'].obs;
  TrainerModel? trainer;
  List<TrainingModel> training = [
    TrainingModel(
      name: 'name',
      training: 'Novo exercício',
      weight: 0,
      series: 0,
      repetitions: 0,
    ),
    TrainingModel(
      name: 'name',
      training: 'Novo exercício',
      weight: 0,
      series: 0,
      repetitions: 0,
    ),
    TrainingModel(
      name: 'name',
      training: 'Novo exercício',
      weight: 0,
      series: 0,
      repetitions: 0,
    ),
    TrainingModel(
      name: 'name',
      training: 'Novo exercício',
      weight: 0,
      series: 0,
      repetitions: 0,
    ),
    TrainingModel(
      name: 'name',
      training: 'Novo exercício',
      weight: 0,
      series: 0,
      repetitions: 0,
    ),
  ];

  static TrainingClientAllListController get i => Get.find();

  @override
  void onInit() {
    super.onInit();
    change(state, status: RxStatus.loading());
    getData();
  }

  Future<void> getData() async {
    try {
      while (ContractTrainerController.i.trainers.isEmpty) {
        await Future.delayed(const Duration(seconds: 2));
      }
      trainer = ContractTrainerController.i.trainers.firstWhere(
        (element) => element.clients.every(
          (element) =>
              element.clientId == FirebaseAuth.instance.currentUser?.uid,
        ),
      );
      change(trainer, status: RxStatus.success());
    } catch (e) {
      Logger().d(e);
      change(trainer, status: RxStatus.empty());
    }
  }

  void goToTraining(int index) {
    Get.toNamed(
      Routes.toTrainingClientOne,
      arguments: training,
    );
  }
}
