import 'package:get/get.dart';
import 'package:play_workout/screens/chat/controller/chat_controller.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ChatController());
  }
}
