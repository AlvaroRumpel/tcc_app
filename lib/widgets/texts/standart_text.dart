import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tcc_app/utils/custom_colors.dart';

class StandartText extends StatelessWidget {
  String text;
  bool isLabel;
  TextAlign align = TextAlign.left;
  Color? color;
  double? fontSize;
  FontWeight fontWeight;

  StandartText({
    Key? key,
    required this.text,
    this.isLabel = false,
    this.align = TextAlign.left,
    this.color = CustomColors.primaryColor,
    this.fontSize = 24,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLabel) {
      color = CustomColors.labelColor;
      fontSize = 16;
    }
    return Padding(
      padding: isLabel
          ? const EdgeInsets.symmetric(vertical: 0, horizontal: 8)
          : const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          decoration: TextDecoration.none,
        ),
        textAlign: align,
      ),
    );
  }
}
