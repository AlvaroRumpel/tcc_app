import 'package:get/get.dart';
import 'package:tcc_app/screens/profile_personal/controller/profile_personal_controller.dart';

class ProfilePersonalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfilePersonalController());
  }
}
