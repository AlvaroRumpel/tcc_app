import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:play_workout/utils/custom_colors.dart';

class MessageText extends StatelessWidget {
  String text;
  bool isWhoSent;
  String time;

  MessageText({
    Key? key,
    required this.text,
    required this.isWhoSent,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:
            isWhoSent ? CustomColors.sentMessage : CustomColors.reciviedMessage,
      ),
      child: Column(
        crossAxisAlignment:
            isWhoSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          SelectableText(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: CustomColors.blackSecondary,
            ),
          ),
          Text(
            time.substring(11, 16),
            textAlign: TextAlign.end,
            style: GoogleFonts.poppins(
              color: CustomColors.blackSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
