import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/models/trainer_model.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/buttons/standart_button.dart';
import 'package:tcc_app/widgets/buttons/success_button.dart';
import 'package:tcc_app/widgets/texts/number_clients_text.dart';
import 'package:tcc_app/widgets/texts/price_text.dart';

class TrainerModal {
  TrainerModal.defaultTrainerModal(TrainerModel trainer) {
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
            function: () {},
          ),
          SuccessButton(text: 'Contratar', function: () {})
        ],
      ),
    );
  }
}
