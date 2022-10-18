import 'package:get/get.dart';
import 'package:play_workout/screens/chat_list/controller/chat_list_controller.dart';
import 'package:play_workout/screens/chat_list/service/chat_list_service.dart';

class ChatListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ChatListService());
    Get.lazyPut(
      () => ChatListController(
        service: ChatListService(),
      ),
    );
  }
}
