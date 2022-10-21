import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_workout/models/chat_pattern_model.dart';
import 'package:play_workout/screens/chat_list/controller/chat_list_controller.dart';
import 'package:play_workout/utils/custom_colors.dart';
import 'package:play_workout/utils/empty_state.dart';
import 'package:play_workout/widgets/standart_scaffold.dart';
import 'package:play_workout/widgets/texts/standart_text.dart';

class ChatListPage extends GetView<ChatListController> {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
      appBar: true,
      title: 'Conversas',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: controller.obx(
          (state) => ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: state!.length,
            itemBuilder: (_, index) => InkWell(
              onTap: () async => await controller.goToChat(
                ChatPatternModel(
                  receiverId: controller.isClient
                      ? state[index].chatConversation!.trainer
                      : state[index].chatConversation!.client,
                  isClient: controller.isClient,
                  fcmTokenToSend: controller.isClient
                      ? state[index].chatConversation!.trainerFcmToken
                      : state[index].chatConversation!.clientFcmToken,
                  senderId: !controller.isClient
                      ? state[index].chatConversation!.trainer
                      : state[index].chatConversation!.client,
                ),
                state[index].notifications,
              ),
              child: Padding(
                padding: index == 0
                    ? const EdgeInsets.only(bottom: 8)
                    : const EdgeInsets.symmetric(vertical: 8.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 0,
                            offset: const Offset(2, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: CustomColors.whiteStandard,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StandartText(
                            text: state[index].name ?? '',
                            fontSize: 16,
                            padding: const EdgeInsets.all(0),
                            fontWeight: FontWeight.w600,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: StandartText(
                                  text:
                                      '${state[index].chatConversation!.messages!.first.whoSent == controller.service.userId ? 'Você' : state[index].name!}: ${state[index].chatConversation!.messages!.first.message}',
                                  fontSize: 16,
                                  padding: const EdgeInsets.all(0),
                                  color: CustomColors.blackStandard,
                                ),
                              ),
                              StandartText(
                                text: state[index]
                                        .chatConversation
                                        ?.messages
                                        ?.first
                                        .sendDate
                                        .substring(11, 16) ??
                                    '',
                                fontSize: 16,
                                padding: const EdgeInsets.all(0),
                                color: CustomColors.blackStandard,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: state[index]
                              .notifications
                              ?.any((element) => !element.read) ??
                          false,
                      child: const Positioned(
                        top: -4,
                        right: -4,
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: CircleAvatar(
                            backgroundColor: CustomColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onEmpty: EmptyState(),
          onLoading: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
