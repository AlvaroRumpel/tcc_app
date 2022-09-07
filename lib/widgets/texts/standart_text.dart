import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:play_workout/utils/custom_colors.dart';

class StandartText extends StatelessWidget {
  String text;
  bool isLabel;
  TextAlign align = TextAlign.left;
  Color? color;
  double fontSize;
  FontWeight fontWeight;
  EdgeInsetsGeometry padding;
  bool isSelectable;

  StandartText({
    Key? key,
    required this.text,
    this.isLabel = false,
    this.align = TextAlign.left,
    this.color = CustomColors.primaryColor,
    this.fontSize = 24,
    this.fontWeight = FontWeight.normal,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    this.isSelectable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLabel) {
      color =
          color != CustomColors.primaryColor ? color : CustomColors.labelColor;
      fontSize = fontSize != 24 ? fontSize : 16;
      padding = const EdgeInsets.symmetric(vertical: 0, horizontal: 8);
    }
    return Padding(
      padding: padding,
      child: isSelectable
          ? SelectableText(
              text,
              style: GoogleFonts.poppins(
                fontSize: fontSize,
                color: color,
                fontWeight: fontWeight,
                decoration: TextDecoration.none,
              ),
              textAlign: align,
            )
          : Text(
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
