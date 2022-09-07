import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_workout/utils/custom_colors.dart';

class StandartOutlinedButton extends StatelessWidget {
  String text;
  Function function;
  double width;
  double height;
  bool smallText;
  IconData? leadingIcon;
  IconData? finalIcon;
  bool dense;

  StandartOutlinedButton({
    Key? key,
    required this.text,
    required this.function,
    this.width = 0,
    this.height = 48,
    this.smallText = false,
    this.leadingIcon,
    this.finalIcon,
    this.dense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: dense
          ? const EdgeInsets.symmetric(vertical: 0, horizontal: 0)
          : const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
              return Size(width, height);
            }),
          ),
          child: Row(
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
                    color: CustomColors.primaryColor,
                    fontSize: 16,
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
