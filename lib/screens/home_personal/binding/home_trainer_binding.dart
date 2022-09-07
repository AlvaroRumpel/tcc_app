import 'package:get/get.dart';
import 'package:play_workout/screens/home_personal/controller/home_trainer_controller.dart';

class HomeTrainerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeTrainerController());
  }
}
