import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/utils/custom_colors.dart';

class SmallText extends StatelessWidget {
  String text;
  Color? color = CustomColors.blackStandard;
  bool bigger = false;
  SmallText({
    Key? key,
    required this.text,
    this.color = CustomColors.blackStandard,
    this.bigger = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: bigger ? 16 : 12,
          color: color,
        ),
      ),
    );
  }
}
