import 'package:get/get.dart';

import 'package:tcc_app/global/global_service.dart';
import 'package:tcc_app/models/trainer_model.dart';
import 'package:tcc_app/models/trainer_user_model.dart';
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
}
