import 'package:get/get.dart';

class Routes {
  static Future? toHomeClient = Get.toNamed('/home');
  static Future? offToHomeClient = Get.offAndToNamed('/home');
  static Future? toHomePersonal = Get.toNamed('/home-personal');
  static Future? offToHomePersonal = Get.offAndToNamed('/home-personal');
  static Future? toLogin = Get.offAndToNamed('/login');
  static Future? toSingUp = Get.toNamed('/cadastro');
  static Future? toClientSingUp = Get.toNamed('/client-singup');
  static Future? toPersonalSingUp = Get.toNamed('/personal-singup');
  static Future? toClientProfile = Get.toNamed('/profile-client');
}
