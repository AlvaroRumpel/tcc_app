import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/utils/custom_colors.dart';

class TitleText extends StatelessWidget {
  String text;
  TitleText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: CustomColors.primaryColor,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
