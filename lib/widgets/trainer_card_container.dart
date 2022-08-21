import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/buttons/standart_button.dart';
import 'package:tcc_app/widgets/texts/number_clients_text.dart';
import 'package:tcc_app/widgets/texts/price_text.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';

class TrainerCardContainer extends StatelessWidget {
  Function onTap;
  Alignment alignment;
  String name;
  int numberClients;
  double price;
  double rating;
  String id;

  TrainerCardContainer({
    Key? key,
    required this.onTap,
    this.alignment = Alignment.center,
    required this.name,
    required this.numberClients,
    required this.price,
    required this.rating,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            color: CustomColors.whiteStandard,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: Avatar(
                  name: name.toUpperCase(),
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
                          child: StandartText(text: name),
                        ),
                        Row(
                          children: [
                            Text(
                              rating.toString().substring(0, 1),
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
                        NumberClientsText(text: numberClients.toString()),
                        PriceText(
                            text:
                                '${price.toString().split('.')[0]},${price.toString().split('.')[1]}'),
                      ],
                    ),
                    StandartButton(
                      text: 'Chat',
                      function: () => Get.toNamed(Routes.toWhithoutIdChat + id),
                      leadingIcon: FontAwesome.chat_empty,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
