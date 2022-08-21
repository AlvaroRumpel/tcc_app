import 'package:get/get.dart';
import 'package:tcc_app/models/training_model.dart';
import 'package:tcc_app/routes/routes.dart';

class TrainingPersonalAllListController extends GetxController {
  RxList<String> trainings = ['a', 'b', 'c', 'd'].obs;

  Future<void> goingToTraining(String name) async {
    var training = TrainingModel(
      name: name,
      training: 'Novo exercício',
      weight: 0,
      series: 0,
      repetitions: 0,
    );
    List<TrainingModel> list = [];

    list.add(training);

    await Get.toNamed(
      Routes.toTrainingPersonalOne,
      arguments: list,
    );
  }
}
