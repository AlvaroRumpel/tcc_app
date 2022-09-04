import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:get/get.dart';

import 'package:tcc_app/global/global_service.dart';
import 'package:tcc_app/models/trainer_model.dart';
import 'package:tcc_app/models/trainer_user_model.dart';
import 'package:tcc_app/models/training_finished_model.dart';
import 'package:tcc_app/models/user_model.dart';
import 'package:tcc_app/models/user_trainer_model.dart';
import 'package:tcc_app/services/local_storage.dart';

class GlobalController extends GetxController {
  GlobalController({
    required this.service,
  });

  GlobalService service;

  static GlobalController get i => Get.find();

  UserModel? client;
  TrainerModel? trainer;
  List<TrainingFinishedModel> progress = [];
  var androidConfig = const FlutterBackgroundAndroidConfig(
    notificationTitle: "Training App",
    notificationText: "O aplicativo está rodando em segundo plano",
    notificationImportance: AndroidNotificationImportance.Default,
    notificationIcon:
        AndroidResource(name: 'ic_launcher', defType: 'mipmap-hdpi'),
  );
  @override
  void onInit() async {
    super.onInit();
    await FlutterBackground.initialize(androidConfig: androidConfig);
  }

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
    trainer = await service.getTrainer(idTrainer: idTrainer);
    if (trainer == null) return;

    await LocalStorage.setTrainer(trainer!);
  }

  Future<void> getHistory({String? idClient}) async {
    progress = await service.getHistory(idClient: idClient) ?? [];
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

  int xpNeededForNextLevel({UserTrainerModel? userTrainerModel}) {
    const exponent = 1.5;
    const baseXp = 250;
    if (userTrainerModel != null) {
      return (baseXp * pow(userTrainerModel.level, exponent)).floor();
    }
    return (baseXp * pow(client!.level, exponent)).floor();
  }

  Future<void> updateTrainer() async {
    if (trainer == null) {
      var trainerId = client!.trainers
          .firstWhereOrNull((element) => element.accepted && element.active)
          ?.trainerId;
      trainer = await service.getTrainer(idTrainer: trainerId);
      return;
    }
    UserTrainerModel? old = trainer!.clients.firstWhereOrNull((element) =>
        element.clientId == FirebaseAuth.instance.currentUser!.uid);
    UserTrainerModel newModel = UserTrainerModel(
      id: old!.id,
      name: client?.name ?? old.name,
      accepted: old.accepted,
      active: old.active,
      birthDate: client!.birthDate,
      bodyFat: client!.bodyFat,
      clientId: client?.clientId ?? old.clientId,
      goal: client?.goal ?? old.goal,
      hasResponse: old.hasResponse,
      height: client?.height ?? old.height,
      level: client!.level,
      sex: old.sex,
      weight: client?.weight ?? old.weight,
      xp: client!.xp,
    );

    trainer!.clients[trainer!.clients
        .indexWhere((element) => element.id == newModel.id)] = newModel;
  }
}
