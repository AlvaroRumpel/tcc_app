import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/models/trainer_model.dart';

class ProfilePersonalController extends GetxController
    with StateMixin<TrainerModel> {
  TrainerModel? trainer;
  User? user;

  GlobalController globalController = GlobalController.i;

  @override
  void onInit() async {
    super.onInit();
    change(state, status: RxStatus.loading());
    await getData();
  }

  Future<void> getData({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        await globalController.getTrainer();
      }
      trainer = globalController.trainer;
      user = FirebaseAuth.instance.currentUser;
      change(trainer, status: RxStatus.success());
    } catch (e) {
      change(state, status: RxStatus.empty());
    }
  }
}
