import 'package:get/get.dart';
import 'package:play_workout/screens/profile/controller/profile_controller.dart';
import 'package:play_workout/screens/profile/service/profile_service.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProfileService());
    Get.lazyPut(() => ProfileController(service: ProfileService()));
  }
}
