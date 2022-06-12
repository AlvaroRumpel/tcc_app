import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tcc_app/config/database_variables.dart';
import 'package:tcc_app/models/trainer_model.dart';
import 'package:tcc_app/widgets/trainer_modal.dart';

class ContractTrainerController extends GetxController
    with StateMixin<List<TrainerModel>> {
  ContractTrainerController({Key? key});
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<TrainerModel> trainers = [];

  @override
  void onInit() {
    super.onInit();
    change(state, status: RxStatus.loading());
    getData();
  }

  void openTrainerModal(int index) {
    TrainerModal.defaultTrainerModal(trainers[index]);
  }

  void getData() async {
    try {
      change(trainers, status: RxStatus.loading());
      var response = await db.collection(DB.trainers).get();
      for (var item in response.docs) {
        trainers.add(TrainerModel.fromMap(item.data()));
      }
      change(trainers, status: RxStatus.success());
    } catch (e) {
      Logger().d(e);
      change(trainers, status: RxStatus.empty());
    }
  }
}
