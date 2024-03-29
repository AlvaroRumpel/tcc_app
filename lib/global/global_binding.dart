import 'package:get/get.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/global/global_service.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<GlobalService>(GlobalService());
    Get.put<GlobalController>(
      GlobalController(
        service: GlobalService(),
      ),
      permanent: true,
    );
  }
}
