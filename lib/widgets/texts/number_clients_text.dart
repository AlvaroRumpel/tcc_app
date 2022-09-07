import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:play_workout/utils/custom_colors.dart';

class NumberClientsText extends StatelessWidget {
  String text;
  Color color;

  NumberClientsText({
    Key? key,
    required this.text,
    this.color = CustomColors.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Row(
        children: [
          Icon(
            Icons.people_alt_outlined,
            color: color,
            size: 32,
          ),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 24,
              color: color,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
