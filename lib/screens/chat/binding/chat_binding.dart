import 'package:get/get.dart';
import 'package:tcc_app/screens/chat/controller/chat_controller.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ChatController());
  }
}
