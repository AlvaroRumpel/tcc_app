import 'package:get/get.dart';
import 'package:tcc_app/screens/profile/controller/profile_controller.dart';
import 'package:tcc_app/screens/profile/service/profile_service.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProfileService());
    Get.lazyPut(() => ProfileController(service: ProfileService()));
  }
}
