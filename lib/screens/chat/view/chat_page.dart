import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/screens/chat/controller/chat_controller.dart';
import 'package:tcc_app/screens/chat/view/adapter/chat_message_adapter.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/utils/empty_state.dart';
import 'package:tcc_app/widgets/buttons/standart_icon_button.dart';
import 'package:tcc_app/widgets/chat_textfield.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
      appBar: true,
      title: "Chat",
      bottomNavigationBar: const Visibility(
        visible: false,
        child: Text(''),
      ),
      body: StandartContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 10,
              child: controller.obx(
                (state) => ListView.separated(
                  shrinkWrap: true,
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state!.messages!.length,
                  itemBuilder: (_, index) => ChatMessageAdapter(
                    message: state.messages![index],
                  ),
                  separatorBuilder: (_, index) => const Divider(
                    color: CustomColors.whiteStandard,
                    height: 5,
                  ),
                ),
                onLoading: const Center(
                  child: CircularProgressIndicator(),
                ),
                onEmpty: EmptyState(
                  withContainer: false,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: ChatTextfield(
                        controller: controller.messageController,
                        hintText: 'Escreva aqui...'),
                  ),
                  Expanded(
                    flex: 2,
                    child: StandartIconButton(
                      function: () => controller.sendMessage(),
                      icon: Icons.send,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
