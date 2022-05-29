import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/utils/custom_colors.dart';

class SmallText extends StatelessWidget {
  String text;
  Color? color = CustomColors.blackStandard;
  bool bigger = false;
  Color? backgroundColor;
  TextAlign? textAlignment;
  SmallText({
    Key? key,
    required this.text,
    this.color = CustomColors.blackStandard,
    this.bigger = false,
    this.backgroundColor,
    this.textAlignment = TextAlign.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Text(
        text,
        textAlign: textAlignment,
        overflow: TextOverflow.fade,
        style: GoogleFonts.poppins(
          fontSize: bigger ? 16 : 12,
          color: color,
        ),
      ),
    );
  }
}
