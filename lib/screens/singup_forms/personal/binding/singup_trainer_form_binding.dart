import 'package:get/get.dart';
import 'package:play_workout/screens/singup_forms/personal/controller/singup_trainer_controller.dart';

class SingupTrainerFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingupTrainerFormController());
  }
}
