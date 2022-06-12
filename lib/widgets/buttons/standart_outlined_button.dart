import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/utils/custom_colors.dart';

class StandartOutlinedButton extends StatelessWidget {
  String text;
  Function function;
  StandartOutlinedButton({
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
        child: OutlinedButton(
          onPressed: () => function(),
          // style: OutlinedButton.styleFrom(
          //   primary: CustomColors.primaryColor,
          //   backgroundColor: CustomColors.whiteStandard,
          //   side: const BorderSide(
          //     color: CustomColors.primaryColor,
          //     width: 2,
          //   ),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10.0),
          //   ),
          //   elevation: 1,
          //   minimumSize: const Size(double.maxFinite, 56),
          // ),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              return CustomColors.containerButton;
            }),
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return CustomColors.whiteStandard.withOpacity(0.8);
              }
              if (states.contains(MaterialState.selected)) {
                return CustomColors.whiteStandard.withOpacity(0.6);
              }
              if (states.contains(MaterialState.dragged)) {
                return CustomColors.whiteStandard.withOpacity(0.4);
              }
              return CustomColors.whiteStandard;
            }),
            side: MaterialStateProperty.resolveWith<BorderSide?>(
                (Set<MaterialState> states) {
              return const BorderSide(
                color: CustomColors.primaryColor,
                width: 2,
              );
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
              color: CustomColors.primaryColor,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
