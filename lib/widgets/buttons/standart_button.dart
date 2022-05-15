import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tcc_app/utils/custom_colors.dart';

class StandartButton extends StatelessWidget {
  String text;
  Function function;
  bool smallText = false;
  StandartButton({
    Key? key,
    required this.text,
    required this.function,
    this.smallText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: CustomColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 1,
          minimumSize: const Size(double.maxFinite, 56),
        ),
        onPressed: () => function(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  color: CustomColors.containerButton,
                  fontSize: smallText ? 16 : 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
