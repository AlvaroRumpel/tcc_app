import 'package:get/get.dart';
import 'package:tcc_app/screens/home_personal/controller/home_trainer_controller.dart';

class HomeTrainerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeTrainerController());
  }
}
