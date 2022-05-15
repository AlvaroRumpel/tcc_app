import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/utils/custom_colors.dart';

class StandartText extends StatelessWidget {
  String text;
  bool isLabel = false;
  StandartText({
    Key? key,
    required this.text,
    this.isLabel = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isLabel
          ? const EdgeInsets.symmetric(vertical: 0, horizontal: 8)
          : const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: isLabel ? 16 : 24,
          color: isLabel ? CustomColors.labelColor : CustomColors.primaryColor,
        ),
      ),
    );
  }
}
