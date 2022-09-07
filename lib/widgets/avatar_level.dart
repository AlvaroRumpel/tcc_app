import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:play_workout/utils/custom_colors.dart';

class AvatarLevel extends StatelessWidget {
  String name;
  int level;
  double size;
  Color borderColor;
  Color textColor;
  FontWeight fontWeight;

  AvatarLevel({
    Key? key,
    required this.name,
    required this.level,
    this.size = 56,
    this.borderColor = CustomColors.sucessColor,
    this.textColor = CustomColors.whiteStandard,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Avatar(
            name: name.toUpperCase(),
            border: Border.all(
              color: borderColor,
              width: 4,
            ),
            shape: AvatarShape.circle(size),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: level.toString().length < 4 ? 32.0 : 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: borderColor,
          ),
          child: Text(
            level.toString(),
            style: GoogleFonts.poppins(
              color: textColor,
              fontSize: 24,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ],
    );
  }
}
