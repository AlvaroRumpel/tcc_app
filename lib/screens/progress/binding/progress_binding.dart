import 'package:get/get.dart';
import 'package:tcc_app/screens/progress/controller/progress_controller.dart';

class ProgressBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProgressController());
  }
}
