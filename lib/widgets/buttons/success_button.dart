import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_workout/utils/custom_colors.dart';

class SuccessButton extends StatelessWidget {
  String text;
  Function function;
  SuccessButton({
    Key? key,
    required this.text,
    required this.function,
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
          onPressed: () => function(),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              return CustomColors.sucessColor;
            }),
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return CustomColors.sucessColor.withOpacity(0.8);
              }
              if (states.contains(MaterialState.selected)) {
                return CustomColors.sucessColor.withOpacity(0.6);
              }
              if (states.contains(MaterialState.dragged)) {
                return CustomColors.sucessColor.withOpacity(0.4);
              }
              return CustomColors.sucessColor;
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
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: CustomColors.whiteStandard,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
