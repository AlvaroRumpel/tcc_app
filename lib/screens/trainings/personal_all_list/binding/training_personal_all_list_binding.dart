import 'package:get/get.dart';
import 'package:play_workout/screens/trainings/personal_all_list/controller/training_personal_all_list_controller.dart';

class TrainingPersonalAllListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainingPersonalAllListController());
  }
}
