import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_workout/utils/custom_colors.dart';

class PriceText extends StatelessWidget {
  String text;
  Color color;
  double fontSize;
  PriceText({
    Key? key,
    required this.text,
    this.color = CustomColors.primaryColor,
    this.fontSize = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'R\$ $text',
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            color: color,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '/Semana',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
          ),
          textAlign: TextAlign.right,
        )
      ],
    );
  }
}
