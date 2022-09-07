import 'package:get/get.dart';
import 'package:play_workout/screens/singup_forms/client/controller/singup_client_form_controller.dart';

class SingupClientFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingupClientFormController());
  }
}
