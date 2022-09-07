import 'package:get/get.dart';
import 'package:play_workout/screens/progress/controller/progress_controller.dart';

class ProgressBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProgressController());
  }
}
