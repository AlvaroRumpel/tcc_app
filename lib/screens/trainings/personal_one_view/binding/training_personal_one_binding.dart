import 'package:get/get.dart';
import 'package:tcc_app/screens/trainings/personal_one_view/controller/training_personal_one_controller.dart';

class TrainingPersonalOneBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainingPersonalOneController());
  }
}
