import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tcc_app/config/database_variables.dart';
import 'package:tcc_app/models/trainer_model.dart';
import 'package:tcc_app/utils/utils_widgets.dart';
import 'package:tcc_app/widgets/trainer_modal.dart';

class ContractTrainerController extends GetxController
    with StateMixin<List<TrainerModel>> {
  ContractTrainerController({Key? key});
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<TrainerModel> trainers = [];
  Rx<TextEditingController> searchController = TextEditingController().obs;

  static ContractTrainerController get i => Get.find();

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
      var response = await db.collection(DB.trainers).get();
      for (var item in response.docs) {
        trainers.add(TrainerModel.fromMap(item.data(), item.id));
      }
      change(trainers, status: RxStatus.success());
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
