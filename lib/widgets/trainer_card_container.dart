import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/models/trainer_model.dart';

import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/buttons/standart_button.dart';
import 'package:tcc_app/widgets/texts/number_clients_text.dart';
import 'package:tcc_app/widgets/texts/price_text.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';

class TrainerCardContainer extends StatelessWidget {
  Function onTap;
  Alignment alignment;
  TrainerModel trainer;
  Color color = CustomColors.whiteStandard;
  bool actualTrainer;

  TrainerCardContainer({
    Key? key,
    required this.onTap,
    this.alignment = Alignment.center,
    required this.trainer,
    this.actualTrainer = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (actualTrainer) {
      color = CustomColors.selectedCard;
    }
    return GestureDetector(
      onTap: () => onTap(),
      child: Center(
        child: Container(
          alignment: alignment,
          padding: const EdgeInsets.all(8),
          width: (MediaQuery.of(context).size.width) * 0.85,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 0,
                offset: const Offset(2, 2), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: color,
          ),
          child: Column(
            children: [
              Visibility(
                visible: actualTrainer,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: CustomColors.primaryColor,
                  ),
                  child: StandartText(
                    text: 'Personal atual',
                    fontSize: 16,
                    color: CustomColors.whiteStandard,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 1,
                    child: Avatar(
                      name: trainer.firstName.toUpperCase(),
                      shape: AvatarShape.circle(32),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: StandartText(text: trainer.firstName),
                            ),
                            Row(
                              children: [
                                Text(
                                  trainer.rating.toString().substring(0, 1),
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    color: CustomColors.tertiaryColor,
                                  ),
                                ),
                                RatingBarIndicator(
                                  itemSize: 24,
                                  itemCount: 1,
                                  rating: 1,
                                  itemBuilder: ((context, index) => const Icon(
                                        Icons.star,
                                        color: CustomColors.tertiaryColor,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NumberClientsText(
                                text: trainer.numberClients.toString()),
                            PriceText(
                                text:
                                    '${trainer.price.toString().split('.')[0]},${trainer.price.toString().split('.')[1]}'),
                          ],
                        ),
                        StandartButton(
                          text: 'Chat',
                          function: () => Get.toNamed(
                            Routes.toChat,
                            arguments: trainer,
                          ),
                          leadingIcon: FontAwesome.chat_empty,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
