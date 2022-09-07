import 'package:avatars/avatars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:play_workout/config/database_variables.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/models/trainer_model.dart';
import 'package:play_workout/models/user_trainer_model.dart';
import 'package:play_workout/routes/routes.dart';
import 'package:play_workout/services/user_service.dart';
import 'package:play_workout/utils/custom_colors.dart';
import 'package:play_workout/utils/utils_widgets.dart';
import 'package:play_workout/widgets/buttons/standart_button.dart';
import 'package:play_workout/widgets/buttons/standart_icon_button.dart';
import 'package:play_workout/widgets/texts/small_text.dart';
import 'package:play_workout/widgets/texts/standart_text.dart';

class HomeTrainerController extends GetxController
    with StateMixin<List<UserTrainerModel>> {
  User? user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance.collection(DB.trainers);
  GlobalController globalController = GlobalController.i;
  TrainerModel? trainer;
  static HomeTrainerController get i => Get.find();

  @override
  void onInit() async {
    super.onInit();
    await getData();
  }

  Future<void> getData() async {
    try {
      change(state, status: RxStatus.loading());
      if (globalController.trainer == null) {
        await globalController.getTrainer(idTrainer: trainer?.trainerId);
      }
      trainer = globalController.trainer;
      change(
        trainer != null ? trainer!.clients : state,
        status: trainer != null
            ? trainer!.clients.isEmpty
                ? RxStatus.empty()
                : RxStatus.success()
            : RxStatus.empty(),
      );
    } catch (e) {
      change(state, status: RxStatus.empty());
      UtilsWidgets.errorSnackbar(description: e.toString());
    }
  }

  void openClientModal(UserTrainerModel client) {
    double xpPercent = client.xp /
        globalController.xpNeededForNextLevel(userTrainerModel: client);
    Get.defaultDialog(
      title: "",
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      radius: 10,
      backgroundColor: CustomColors.whiteStandard,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16.0),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff364151),
                  Color(0xff4D6382),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: !client.hasResponse,
                  child: SmallText(
                    color: CustomColors.whiteStandard,
                    textAlignment: TextAlign.right,
                    text: 'Aguardando Resposta',
                    backgroundColor: CustomColors.primaryColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Avatar(
                      name: client.name.toUpperCase(),
                      shape: AvatarShape.circle(36),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StandartText(
                          text: client.name,
                          color: CustomColors.whiteStandard,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StandartText(
                              text:
                                  ('${client.height.toString().substring(0, 1)}.${client.height.toString().substring(1)}'),
                              color: CustomColors.whiteStandard,
                            ),
                            StandartText(
                              text: '${client.weight} Kg',
                              color: CustomColors.whiteStandard,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                StandartText(
                  text: 'Nivel ${client.level}',
                  color: CustomColors.sucessColor,
                ),
                LinearPercentIndicator(
                  barRadius: const Radius.circular(10),
                  backgroundColor: CustomColors.whiteStandard,
                  progressColor: CustomColors.sucessColor,
                  lineHeight: 16,
                  percent: xpPercent.isNaN ? 0 : xpPercent,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Visibility(
              visible: !client.hasResponse,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: StandartIconButton(
                        icon: Icons.check,
                        backgroundColor: CustomColors.sucessColor,
                        function: () => UserService.responseClient(
                          client.clientId,
                          true,
                          callback: getData,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: StandartIconButton(
                      icon: Icons.cancel_outlined,
                      isOutlined: true,
                      function: () => UserService.responseClient(
                        client.clientId,
                        false,
                        callback: getData,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          StandartButton(
            text: 'Progresso',
            function: () => Get.toNamed(
              Routes.toProgressClient,
              arguments: client.clientId,
            ),
          ),
          Visibility(
            visible: client.accepted,
            child: StandartButton(
              text: 'Treinos',
              function: () => Get.toNamed(
                Routes.toTrainingPersonalAllList,
                arguments: client.clientId,
              ),
            ),
          ),
          StandartButton(
            text: 'Chat',
            function: () => Get.toNamed(
              Routes.toChat,
              arguments: client,
            ),
            leadingIcon: FontAwesome.chat_empty,
          ),
        ],
      ),
    );
  }
}
