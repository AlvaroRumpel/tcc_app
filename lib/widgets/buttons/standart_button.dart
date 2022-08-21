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
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              return CustomColors.primaryColor;
            }),
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return CustomColors.primaryColor.withOpacity(0.8);
              }
              if (states.contains(MaterialState.selected)) {
                return CustomColors.primaryColor.withOpacity(0.6);
              }
              if (states.contains(MaterialState.dragged)) {
                return CustomColors.primaryColor.withOpacity(0.4);
              }
              return CustomColors.primaryColor;
            }),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
                (Set<MaterialState> states) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              );
            }),
            minimumSize: MaterialStateProperty.resolveWith<Size?>(
                (Set<MaterialState> states) {
              return const Size(double.maxFinite, 48);
            }),
          ),
          onPressed: () => function(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                leadingIcon,
                size: smallText ? 16 : 24,
                color: CustomColors.whiteStandard,
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
              Icon(
                finalIcon,
                size: smallText ? 16 : 24,
                color: CustomColors.whiteStandard,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
