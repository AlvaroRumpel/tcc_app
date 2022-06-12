import 'package:get/get.dart';
import 'package:tcc_app/screens/login/controller/login_controller.dart';
import 'package:tcc_app/services/user_service.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserService>(() => UserService());
    Get.lazyPut<LoginController>(
      () => LoginController(
        userService: Get.find(),
      ),
    );
  }
}
