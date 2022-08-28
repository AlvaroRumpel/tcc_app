import 'dart:math';

import 'package:get/get.dart';

import 'package:tcc_app/global/global_service.dart';
import 'package:tcc_app/models/trainer_model.dart';
import 'package:tcc_app/models/trainer_user_model.dart';
import 'package:tcc_app/models/training_finished_model.dart';
import 'package:tcc_app/models/user_model.dart';
import 'package:tcc_app/models/user_trainer_model.dart';
import 'package:tcc_app/services/local_storage.dart';
import 'package:tcc_app/utils/utils_widgets.dart';

class GlobalController extends GetxController {
  GlobalController({
    required this.service,
  });

  GlobalService service;

  static GlobalController get i => Get.find();

  UserModel? client;
  TrainerModel? trainer;
  List<TrainingFinishedModel> progress = [];

  Future<void> getClient({String? idClient}) async {
    client = await service.getClient(idClient: idClient);

    if (client == null) return;

    await LocalStorage.setClient(client!);

    TrainerUserModel? trainerUserModel = client!.trainers
        .firstWhereOrNull((element) => element.accepted && element.active);

    if (trainerUserModel != null) {
      trainer = await service.getTrainer(
        idTrainer: trainerUserModel.trainerId,
      );

      if (trainer == null) return;

      await LocalStorage.setTrainer(trainer!);
    }
  }

  Future<void> getTrainer({String? idTrainer}) async {
    trainer = await service.getTrainer();
    if (trainer == null) return;

    await LocalStorage.setTrainer(trainer!);
  }

  Future<void> getHistory() async {
    progress = await service.getHistory() ?? [];
  }

  bool checkLevel(int xpEarned) {
    client!.xp += xpEarned;

    var xpNeeded = xpNeededForNextLevel();
    if (client!.xp >= xpNeeded) {
      client!.level++;
      client!.xp -= xpNeeded;
      return true;
    }
    return false;
  }

  int xpNeededForNextLevel() {
    const exponent = 1.5;
    const baseXp = 250;
    return (baseXp * pow(client!.level, exponent)).floor();
  }
}
