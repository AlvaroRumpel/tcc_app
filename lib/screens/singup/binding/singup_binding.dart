import 'package:get/get.dart';
import 'package:play_workout/screens/singup/controller/singup_controller.dart';

class SingupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingupController());
  }
}
