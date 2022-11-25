import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/models/workouts_model.dart';
import 'package:play_workout/routes/routes.dart';
import 'package:play_workout/screens/trainings/client_all_list/service/training_client_all_list_service.dart';

class TrainingClientAllListController extends GetxController
    with StateMixin<List<WorkoutsModel>> {
  TrainingClientAllListService service;

  TrainingClientAllListController({
    Key? key,
    required this.service,
  });

  List<WorkoutsModel> workouts = [];
  GlobalController globalController = GlobalController.i;

  static TrainingClientAllListController get i => Get.find();

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    change(state, status: RxStatus.loading());
    workouts.clear();

    if (globalController.trainer == null) {
      change(state, status: RxStatus.empty());
    }

    var isTrainerActive = globalController.trainer!.clients.firstWhereOrNull(
        (element) => element.clientId == globalController.client!.clientId!);

    if (isTrainerActive != null && isTrainerActive.active) {
      workouts = await service.getWorkoutList(
        clientId: globalController.client!.clientId!,
        trainerId: globalController.trainer!.trainerId!,
      );
    }

    change(
      workouts,
      status: workouts.isNotEmpty ? RxStatus.success() : RxStatus.empty(),
    );
  }

  void goToTraining(int index) {
    Get.toNamed(
      Routes.toTrainingClientOne,
      arguments: workouts[index].trainings,
    );
  }
}
