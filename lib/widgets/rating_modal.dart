import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:play_workout/models/trainer_model.dart';
import 'package:play_workout/services/user_service.dart';
import 'package:play_workout/utils/custom_colors.dart';
import 'package:play_workout/widgets/buttons/standart_button.dart';
import 'package:play_workout/widgets/buttons/standart_outlined_button.dart';
import 'package:play_workout/widgets/texts/standart_text.dart';

class RatingModal {
  RatingModal.defaultRatingModal({required TrainerModel trainer}) {
    var controller = Get.put(RatingModalController());
    controller.rating.value = 0;
    Get.defaultDialog(
      radius: 20,
      backgroundColor: CustomColors.whiteStandard,
      title: '',
      titlePadding: const EdgeInsets.all(0),
      titleStyle: const TextStyle(fontSize: 12),
      content: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff364151),
                  Color(0xff4D6382),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Obx(
                  () => StandartText(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    text:
                        'Quantas estrelas ${trainer.firstName} merece? ${controller.rating}',
                    isLabel: true,
                    align: TextAlign.center,
                    fontSize: 24,
                  ),
                ),
                RatingBar.builder(
                  itemPadding: const EdgeInsets.symmetric(vertical: 16),
                  glow: false,
                  allowHalfRating: true,
                  initialRating: 0,
                  itemSize: 48,
                  itemCount: 5,
                  unratedColor: CustomColors.blackSecondary,
                  itemBuilder: (_, index) => const Icon(
                    Icons.star,
                    color: CustomColors.tertiaryColor,
                  ),
                  onRatingUpdate: (value) => controller.onRatingUpdate(value),
                ),
                StandartButton(
                  text: 'Enviar',
                  function: () => controller.makeRating(trainer),
                  color: CustomColors.sucessColor,
                ),
              ],
            ),
          ),
          StandartOutlinedButton(
            text: 'Cancelar',
            function: () => Get.back(),
          ),
        ],
      ),
    );
  }
}

class RatingModalController extends GetxController {
  RatingModalController();
  RxDouble rating = 0.0.obs;
  void onRatingUpdate(double value) {
    rating.value = value;
  }

  Future<void> makeRating(TrainerModel trainer) async {
    await UserService.sendRating(rating: rating.value, trainer: trainer);
  }
}
