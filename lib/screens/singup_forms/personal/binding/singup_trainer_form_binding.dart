import 'package:get/get.dart';
import 'package:tcc_app/screens/singup_forms/personal/controller/singup_trainer_controller.dart';

class SingupTrainerFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingupTrainerFormController());
  }
}
