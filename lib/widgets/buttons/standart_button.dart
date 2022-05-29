import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tcc_app/utils/custom_colors.dart';

class StandartButton extends StatelessWidget {
  String text;
  Function function;
  bool smallText = false;
  IconData? leadingIcon;
  IconData? finalIcon;
  StandartButton({
    Key? key,
    required this.text,
    required this.function,
    this.smallText = false,
    this.leadingIcon,
    this.finalIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 0,
              offset: const Offset(2, 2), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  leadingIcon,
                  size: smallText ? 16 : 24,
                ),
              ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  finalIcon,
                  size: smallText ? 16 : 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
