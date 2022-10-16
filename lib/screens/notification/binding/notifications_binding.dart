import 'package:get/get.dart';
import 'package:play_workout/screens/notification/controller/notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationsController());
  }
}
