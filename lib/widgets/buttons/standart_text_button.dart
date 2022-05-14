import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StandartTextButton extends StatelessWidget {
  Function function;
  String text;
  bool dense = false;
  StandartTextButton({
    Key? key,
    required this.function,
    required this.text,
    this.dense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: dense ? 0 : 8, horizontal: 16.0),
      child: TextButton(
        onPressed: () => function(),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 16,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
