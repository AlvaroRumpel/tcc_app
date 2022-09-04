import 'package:get/get.dart';
import 'package:tcc_app/screens/splash/controller/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
