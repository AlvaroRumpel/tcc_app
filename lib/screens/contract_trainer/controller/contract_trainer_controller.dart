import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:play_workout/config/database_variables.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/models/trainer_model.dart';
import 'package:play_workout/utils/utils_widgets.dart';
import 'package:play_workout/widgets/trainer_modal.dart';

class ContractTrainerController extends GetxController
    with StateMixin<List<TrainerModel>> {
  ContractTrainerController({Key? key});
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<TrainerModel> trainers = [];
  Rx<TextEditingController> searchController = TextEditingController().obs;
  TrainerModel? actualTrainer;
  GlobalController globalController = GlobalController.i;

  static ContractTrainerController get i => Get.find();

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void openTrainerModal(
    int index, {
    TrainerModel? model,
    bool actualTrainer = false,
  }) {
    TrainerModal.defaultTrainerModal(model ?? trainers[index],
        actualTrainer: actualTrainer);
  }

  Future<void> getData() async {
    try {
      change(state, status: RxStatus.loading());
      trainers.clear();
      var response = await db.collection(DB.trainers).get();
      for (var item in response.docs) {
        trainers.add(TrainerModel.fromMap(item.data(), item.id));
      }
      var trainerTemp = globalController.client?.trainers
          .firstWhereOrNull((element) => element.active);

      actualTrainer = trainerTemp != null
          ? trainers.firstWhereOrNull(
              (element) => element.trainerId == trainerTemp.trainerId,
            )
          : null;

      change(trainers,
          status: trainers.isNotEmpty ? RxStatus.success() : RxStatus.empty());
    } catch (e) {
      Logger().d(e);
      change(trainers, status: RxStatus.empty());
    }
  }

  Future<void> search(String value) async {
    await Future.delayed(
      const Duration(
        seconds: 1,
        milliseconds: 500,
      ),
    );
    if (value == searchController.value.text) {
      change(state, status: RxStatus.loading());
      if (value.isEmpty) {
        change(trainers, status: RxStatus.success());
        return;
      }
      List<TrainerModel> trainersSearch = trainers
          .where((element) =>
              element.firstName.startsWith(value) ||
              element.lastName.startsWith(value))
          .toList();
      if (trainersSearch.isEmpty) {
        UtilsWidgets.errorSnackbar(
          title: 'Personal não encontrado',
          description: 'Desculpe! Pesquise novamente outro nome',
        );
      }
      change(
        trainersSearch.isEmpty ? trainers : trainersSearch,
        status: RxStatus.success(),
      );
    }
  }
}
