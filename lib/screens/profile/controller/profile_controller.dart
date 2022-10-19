import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/models/trainer_model.dart';
import 'package:play_workout/models/training_finished_model.dart';
import 'package:play_workout/models/user_model.dart';
import 'package:play_workout/screens/profile/service/profile_service.dart';
import 'package:play_workout/utils/utils_widgets.dart';
import 'package:play_workout/widgets/trainer_modal.dart';

class ProfileController extends GetxController with StateMixin<UserModel> {
  ProfileController({required this.service});
  ProfileService service;
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TrainerModel? trainerComplete;
  UserModel? profile;
  List<FlSpot> progress = [];
  double maxY = 0;
  double maxX = 0;
  List<TrainingFinishedModel> historic = [];
  GlobalController globalController = GlobalController.i;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData({bool isRefresh = false}) async {
    change(state, status: RxStatus.loading());
    if (isRefresh) {
      await globalController.getClient();
    }
    if (isRefresh || globalController.progress.isEmpty) {
      await globalController.getHistory();
    }
    profile = globalController.client;
    trainerComplete = globalController.trainer?.clients.firstWhereOrNull(
                (element) =>
                    element.active &&
                    element.clientId == globalController.client!.clientId) !=
            null
        ? globalController.trainer
        : null;
    historic = globalController.progress;
    await getHistory();

    change(profile ?? state,
        status: profile != null ? RxStatus.success() : RxStatus.empty());

    if (profile == null) {
      UtilsWidgets.errorScreen(message: 'Usuario não encontrado');
    }
  }

  Future<void> getHistory() async {
    progress.clear();
    maxX = historic.length.toDouble() - 1;
    maxY = 0;
    for (var i = 0; i < historic.length; i++) {
      maxY = historic[i].xpEarned.toDouble() > maxY
          ? historic[i].xpEarned.toDouble()
          : maxY;
      progress.add(
        FlSpot(
          i.toDouble(),
          historic[i].xpEarned.toDouble(),
        ),
      );
    }
    maxY += 100;
  }

  void openTrainerModal() {
    TrainerModal.defaultTrainerModal(
      trainerComplete!,
      dismissTrainer: true,
      actualTrainer: true,
    );
  }
}
