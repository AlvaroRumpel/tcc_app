import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_workout/utils/custom_colors.dart';

class TitleText extends StatelessWidget {
  String text;
  bool subtitle = false;
  TitleText({
    Key? key,
    required this.text,
    this.subtitle = false,
  }) : super(key: key);

  double screenWidth = Get.width;
  double subtitleSize = 32;
  double standartSize = 48;

  @override
  Widget build(BuildContext context) {
    if (screenWidth < 360) {
      subtitleSize -= 8;
      standartSize -= 8;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: CustomColors.primaryColor,
          fontSize: subtitle ? 32 : 48,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
