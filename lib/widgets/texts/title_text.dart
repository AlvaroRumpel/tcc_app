import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
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
