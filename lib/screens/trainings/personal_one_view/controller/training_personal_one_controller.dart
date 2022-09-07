import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:play_workout/config/database_variables.dart';
import 'package:play_workout/models/training_model.dart';
import 'package:play_workout/models/workouts_model.dart';
import 'package:play_workout/screens/trainings/personal_all_list/controller/training_personal_all_list_controller.dart';
import 'package:play_workout/utils/utils_widgets.dart';

class TrainingPersonalOneController extends GetxController
    with StateMixin<WorkoutsModel> {
  List<TextEditingController> exerciseController = [];
  List<TextEditingController> repsController = [];
  List<TextEditingController> weightController = [];
  List<TextEditingController> seriesController = [];
  TextEditingController trainingNameController = TextEditingController();
  WorkoutsModel trainingArguments = Get.arguments ?? WorkoutsModel;
  List<TrainingModel> trainingSaved = [];
  RxBool edit = false.obs;
  RxString workoutName = "".obs;

  @override
  void onInit() {
    super.onInit();
    change(state, status: RxStatus.loading());
    setupControllers();
  }

  void setupControllers() {
    if (trainingArguments.trainings.isNotEmpty) {
      int timesToAddControllers =
          (trainingArguments.trainings.length - exerciseController.length) +
              exerciseController.length;

      if (trainingNameController.text.isEmpty) {
        trainingNameController.text = trainingArguments.trainings.first.name;
      }

      workoutName.value = trainingNameController.text;

      for (int i = exerciseController.length; i < timesToAddControllers; i++) {
        exerciseController.insert(
            i,
            TextEditingController(
              text: trainingArguments.trainings[i].training,
            ));

        repsController.insert(
          i,
          TextEditingController(
            text: trainingArguments.trainings[i].repetitions.toString(),
          ),
        );

        weightController.insert(
          i,
          TextEditingController(
            text: trainingArguments.trainings[i].weight.toString(),
          ),
        );

        seriesController.insert(
          i,
          TextEditingController(
            text: trainingArguments.trainings[i].series.toString(),
          ),
        );
      }
    }
    change(
      trainingArguments,
      status: trainingArguments.trainings.isNotEmpty
          ? RxStatus.success()
          : RxStatus.empty(),
    );
  }

  void addExercise() {
    var newTraining = TrainingModel(
      name: trainingArguments.trainings.first.name,
      training: 'Novo exercício',
      weight: 0,
      series: 0,
      repetitions: 0,
    );

    trainingArguments.trainings.add(newTraining);
    setupControllers();
  }

  void removeExercise(int index) {
    if (trainingArguments.trainings.length == 1) {
      UtilsWidgets.errorSnackbar(
        title: 'Você não pode apagar todos os exercicios',
        description: 'Precisa ter pelo menos um exercício no treino',
      );
      return;
    }
    change(state, status: RxStatus.loading());
    trainingArguments.trainings.removeAt(index);
    exerciseController.removeAt(index);
    repsController.removeAt(index);
    weightController.removeAt(index);
    seriesController.removeAt(index);
    change(trainingArguments, status: RxStatus.success());
  }

  void changeToEdit() {
    trainingSaved.clear();
    for (var element in trainingArguments.trainings) {
      trainingSaved.add(
        TrainingModel(
          conclude: element.conclude,
          name: element.name,
          repetitions: element.repetitions,
          series: element.series,
          training: element.training,
          weight: element.weight,
        ),
      );
    }
    edit.value = true;
  }

  Future<void> saveEdit() async {
    for (var index = 0; index < trainingArguments.trainings.length; index++) {
      trainingArguments.trainings[index].name = trainingNameController.text;
      trainingArguments.trainings[index].repetitions =
          int.parse(repsController[index].text);
      trainingArguments.trainings[index].series =
          int.parse(seriesController[index].text);
      trainingArguments.trainings[index].training =
          exerciseController[index].text;
      trainingArguments.trainings[index].weight =
          int.parse(weightController[index].text);
    }
    if (trainingArguments.trainings.length == trainingSaved.length) {
      for (int i = 0; i < trainingArguments.trainings.length; i++) {
        if (trainingArguments.trainings[i].name == trainingSaved[i].name &&
            trainingArguments.trainings[i].repetitions ==
                trainingSaved[i].repetitions &&
            trainingArguments.trainings[i].series == trainingSaved[i].series &&
            trainingArguments.trainings[i].training ==
                trainingSaved[i].training &&
            trainingArguments.trainings[i].weight == trainingSaved[i].weight) {
          edit.value = false;
          return;
        }
      }
    }
    try {
      await FirebaseFirestore.instance
          .collection(DB.workouts)
          .doc(trainingArguments.id)
          .set(trainingArguments.toMap());
      change(trainingArguments, status: RxStatus.success());
      await TrainingPersonalAllListController.i.getData();
    } catch (e) {
      UtilsWidgets.errorSnackbar(
        description: 'Erro ao salvar',
      );
    }
    change(trainingArguments, status: RxStatus.success());
    edit.value = false;
  }

  void cancelEdit() {
    change(state, status: RxStatus.loading());
    trainingArguments.trainings.assignAll(trainingSaved);
    exerciseController.clear();
    repsController.clear();
    weightController.clear();
    seriesController.clear();
    setupControllers();
    edit.value = false;
  }
}
