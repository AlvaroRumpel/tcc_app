import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_workout/models/trainer_model.dart';
import 'package:play_workout/routes/routes.dart';
import 'package:play_workout/services/user_service.dart';
import 'package:play_workout/utils/custom_colors.dart';
import 'package:play_workout/utils/utils_widgets.dart';
import 'package:play_workout/widgets/buttons/standart_button.dart';
import 'package:play_workout/widgets/buttons/success_button.dart';
import 'package:play_workout/widgets/rating_modal.dart';
import 'package:play_workout/widgets/texts/number_clients_text.dart';
import 'package:play_workout/widgets/texts/price_text.dart';

class TrainerModal {
  TrainerModal.defaultTrainerModal(
    TrainerModel trainer, {
    bool dismissTrainer = false,
    bool actualTrainer = false,
  }) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.only(
        top: 0,
        bottom: 8,
        left: 8,
        right: 8,
      ),
      title: '',
      titlePadding: const EdgeInsets.all(0),
      radius: 20,
      content: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff364151),
                  Color(0xff4D6382),
                ],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Avatar(
                    name: '${trainer.firstName} ${trainer.lastName}'
                        .toUpperCase(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingBarIndicator(
                    itemSize: 32,
                    itemCount: 5,
                    rating: trainer.rating,
                    itemBuilder: ((context, index) => const Icon(
                          Icons.star,
                          color: CustomColors.tertiaryColor,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${trainer.firstName} ${trainer.lastName}',
                    style: GoogleFonts.poppins(
                      color: CustomColors.labelColor,
                      fontSize: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      NumberClientsText(
                        color: CustomColors.labelColor,
                        text: trainer.numberClients.toString(),
                      ),
                      PriceText(
                        color: CustomColors.labelColor,
                        text:
                            '${trainer.price.toString().split('.')[0]},${trainer.price.toString().split('.')[1]}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              trainer.about,
              style: GoogleFonts.poppins(
                color: CustomColors.blackStandard,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          StandartButton(
            leadingIcon: FontAwesome.chat_empty,
            text: 'Chat',
            function: () async {
              await Get.toNamed(
                Routes.toChat,
                arguments: trainer,
              );
            },
          ),
          StandartButton(
            text: 'Faça uma avaliação',
            color: CustomColors.sucessColor,
            function: () => RatingModal.defaultRatingModal(trainer: trainer),
          ),
          dismissTrainer || actualTrainer
              ? StandartButton(
                  function: () => dismissTrainerConfirm(trainer.trainerId!),
                  text: 'Demitir',
                  color: CustomColors.errorColor,
                )
              : SuccessButton(
                  text: 'Contratar',
                  function: () =>
                      UserService.contractTrainer(trainer.trainerId!),
                ),
        ],
      ),
    );
  }
  void dismissTrainerConfirm(String trainerId) {
    UtilsWidgets.buttonsDialog(
      title: 'Deseja demitir o profissional?',
      description:
          'Confirmar a demissão deste profissional, você pode recontrata-lo, mas irá perder os treinos.',
      button1: () => UserService.dismissTrainer(trainerId, timesBack: 2),
      textButton1: 'Demitir',
      button1IsOutline: true,
      button2: () {
        Get.back();
        Get.back();
      },
      textButton2: 'Voltar',
      button2Color: CustomColors.sucessColor,
    );
  }
}
