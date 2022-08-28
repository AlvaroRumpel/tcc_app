import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:tcc_app/global/global_controller.dart';
import 'package:tcc_app/models/trainer_model.dart';
import 'package:tcc_app/models/training_finished_model.dart';
import 'package:tcc_app/models/user_model.dart';
import 'package:tcc_app/screens/profile/service/profile_service.dart';
import 'package:tcc_app/utils/utils_widgets.dart';
import 'package:tcc_app/widgets/trainer_modal.dart';

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
    trainerComplete = globalController.trainer;
    historic = globalController.progress;
    await getHistory();

    change(profile ?? state,
        status: profile != null ? RxStatus.success() : RxStatus.empty());
    UtilsWidgets.sucessSnackbar();

    if (profile != null) return;
    UtilsWidgets.errorScreen();
    UtilsWidgets.errorSnackbar(title: 'Usuario não encontrado');
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
    );
  }
}
