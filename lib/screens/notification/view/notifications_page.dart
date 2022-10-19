import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:play_workout/screens/notification/controller/notifications_controller.dart';
import 'package:play_workout/utils/custom_colors.dart';
import 'package:play_workout/utils/empty_state.dart';
import 'package:play_workout/widgets/standart_scaffold.dart';
import 'package:play_workout/widgets/texts/standart_text.dart';

class NotificationsPage extends GetView<NotificationsController> {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
      title: 'Notificações',
      appBar: true,
      body: controller.obx(
        (state) => ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, index) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 0,
                          offset: const Offset(2, 2),
                        ),
                      ],
                      color: state![index].every((element) => element.read)
                          ? CustomColors.whiteStandard
                          : CustomColors.selectedCard,
                    ),
                    child: ExpansionTile(
                      title: StandartText(
                        text: state[index].first.title,
                        color: CustomColors.blackStandard,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        padding: const EdgeInsets.all(0),
                      ),
                      backgroundColor:
                          state[index].every((element) => element.read)
                              ? CustomColors.whiteStandard
                              : CustomColors.selectedCard,
                      expandedAlignment: Alignment.centerLeft,
                      collapsedBackgroundColor:
                          state[index].every((element) => element.read)
                              ? CustomColors.whiteStandard
                              : CustomColors.selectedCard,
                      childrenPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      children: [
                        InkWell(
                            onTap: () async =>
                                await controller.goToNotification(state[index]),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state[index].length > 5
                                  ? 5
                                  : state[index].length,
                              itemBuilder: (_, i) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: StandartText(
                                      text: state[index][i].body,
                                      color: CustomColors.blackStandard,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      padding: const EdgeInsets.all(0),
                                    ),
                                  ),
                                  StandartText(
                                    text: DateFormat('dd/MM - HH:mm')
                                        .format(state[index][i].date),
                                    color: CustomColors.blackStandard,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    padding: const EdgeInsets.all(0),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: state[index].any((element) => !element.read),
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
            );
          },
          separatorBuilder: (_, index) => const Divider(
            height: 8,
          ),
          itemCount: state!.length,
        ),
        onEmpty: EmptyState(text: 'Você não tem notificações'),
      ),
    );
  }
}
