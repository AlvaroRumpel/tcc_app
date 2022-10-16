import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/routes/routes.dart';
import 'package:play_workout/services/local_storage.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    await choiceTypeApp();
  }

  Future<void> choiceTypeApp() async {
    if (FirebaseAuth.instance.currentUser == null) {
      await Get.offAndToNamed(Routes.toLogin);
      return;
    }
    GlobalController.i.getNotifications();
    if (await LocalStorage.getIsClients()) {
      await GlobalController.i.getClient();
      await Get.offAndToNamed(Routes.toHomeClient);
      return;
    }
    await GlobalController.i.getTrainer();
    Get.offAndToNamed(Routes.toHomeTrainer);
    return;
  }
}
