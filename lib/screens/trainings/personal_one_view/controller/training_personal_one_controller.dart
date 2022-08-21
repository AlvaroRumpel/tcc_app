import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tcc_app/models/training_model.dart';

class TrainingPersonalOneController extends GetxController
    with StateMixin<List<TrainingModel>> {
  List<TextEditingController> exerciseController = [];
  List<TextEditingController> repsController = [];
  List<TextEditingController> weightController = [];
  List<TextEditingController> seriesController = [];
  TextEditingController trainingNameController = TextEditingController();
  List<TrainingModel> trainingArguments = Get.arguments ?? [];
  List<TrainingModel> trainingSaved = [];
  RxBool edit = false.obs;

  @override
  void onInit() {
    super.onInit();
    change(state, status: RxStatus.loading());
    setupControllers();
  }

  void setupControllers() {
    if (trainingArguments.isNotEmpty) {
      for (var element in trainingArguments) {
        trainingNameController.text = element.name;
        exerciseController.add(
          TextEditingController(
            text: element.training,
          ),
        );
        repsController.add(
          TextEditingController(
            text: element.repetitions.toString(),
          ),
        );
        weightController.add(
          TextEditingController(
            text: element.weight.toString(),
          ),
        );
        seriesController.add(
          TextEditingController(
            text: element.series.toString(),
          ),
        );
      }
    }
    change(
      trainingArguments,
      status:
          trainingArguments.isNotEmpty ? RxStatus.success() : RxStatus.empty(),
    );
  }

  void addExercise() {
    var newTraining = TrainingModel(
      name: trainingArguments.first.name,
      training: 'Novo exercício',
      weight: 0,
      series: 0,
      repetitions: 0,
    );

    trainingArguments.add(newTraining);
    setupControllers();
  }

  void removeExercise(int index) {
    change(state, status: RxStatus.loading());
    trainingArguments.removeAt(index);
    exerciseController.removeAt(index);
    repsController.removeAt(index);
    weightController.removeAt(index);
    seriesController.removeAt(index);
    change(trainingArguments, status: RxStatus.success());
  }

  void changeToEdit() {
    trainingSaved.assignAll(trainingArguments);
    edit.value = true;
  }

  void saveEdit() {
    for (var index = 0; index < trainingArguments.length; index++) {
      trainingArguments[index].name = trainingNameController.text;
      trainingArguments[index].repetitions =
          int.parse(repsController[index].text);
      trainingArguments[index].series = int.parse(seriesController[index].text);
      trainingArguments[index].training = exerciseController[index].text;
      trainingArguments[index].weight = int.parse(weightController[index].text);
    }
    change(trainingArguments, status: RxStatus.success());
    edit.value = false;
  }

  void cancelEdit() {
    change(state, status: RxStatus.loading());
    trainingArguments.assignAll(trainingSaved);
    exerciseController.clear();
    repsController.clear();
    weightController.clear();
    seriesController.clear();
    setupControllers();
    edit.value = false;
  }
}
