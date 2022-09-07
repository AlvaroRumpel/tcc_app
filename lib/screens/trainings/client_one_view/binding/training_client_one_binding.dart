import 'package:get/get.dart';
import 'package:play_workout/screens/trainings/client_one_view/controller/training_client_one_controller.dart';

class TrainingClientOneBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainingClientOneController());
  }
}
