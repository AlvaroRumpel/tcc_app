import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tcc_app/config/database_variables.dart';
import 'package:tcc_app/models/training_model.dart';
import 'package:tcc_app/models/workouts_model.dart';
import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/utils/utils_widgets.dart';

class TrainingPersonalAllListController extends GetxController
    with StateMixin<List<WorkoutsModel>> {
  List<WorkoutsModel> workouts = [];
  String clientId = Get.arguments ?? '';
  CollectionReference<Map<String, dynamic>> db =
      FirebaseFirestore.instance.collection(DB.workouts);

  static TrainingPersonalAllListController get i => Get.find();

  @override
  void onInit() async {
    super.onInit();
    change(state, status: RxStatus.loading());
    await getData();
  }

  Future<void> getData() async {
    workouts.clear();
    try {
      var response = await db
          .where(
            'client_id',
            isEqualTo: clientId,
          )
          .where(
            'deleted',
            isEqualTo: false,
          )
          .get();

      if (response.docs.isEmpty) {
        change(state, status: RxStatus.empty());
        return;
      }

      for (var item in response.docs) {
        workouts.add(WorkoutsModel.fromMap(item.data(), item.id, true));
      }
      change(workouts, status: RxStatus.success());
    } catch (e) {
      change(workouts, status: RxStatus.error());
      UtilsWidgets.errorSnackbar(
        description: 'Falha ao buscar os treinos',
      );
    }
  }

  void addTraining() {
    workouts.add(
      WorkoutsModel(
        trainings: [TrainingModel()],
        clientId: clientId,
        trainerId: FirebaseAuth.instance.currentUser?.uid ?? '',
        saved: false,
      ),
    );
    change(workouts, status: RxStatus.success());
  }

  void removeTraining(int index) {
    UtilsWidgets.buttonsDialog(
      title: 'Apagar treino?',
      description: 'Tem certeza que deseja apagar este treino?',
      button1: () => deleteWorkout(index),
      textButton1: 'Sim',
      button1IsOutline: true,
      button2: () => Get.back(),
      textButton2: 'Não',
    );
  }

  Future<void> deleteWorkout(int index) async {
    try {
      change(workouts, status: RxStatus.loading());
      workouts[index].deleted = true;
      if (workouts[index].saved) {
        await db.doc(workouts[index].id).set(workouts[index].toMap());
      }
      workouts.removeAt(index);
      change(workouts, status: RxStatus.success());
      Get.back();
    } catch (e) {
      UtilsWidgets.errorSnackbar(description: 'Falha ao realizar a exclusão');
    }
  }

  Future<void> goingToTraining(int index) async {
    await Get.toNamed(
      Routes.toTrainingPersonalOne,
      arguments: workouts[index],
    );
  }
}
