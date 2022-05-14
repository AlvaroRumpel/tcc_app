import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/utils/custom_colors.dart';

class StandartTextfield extends StatelessWidget {
  String labelText;
  bool? obscure;
  StandartTextfield({
    Key? key,
    this.obscure = false,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
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
        child: TextFormField(
          obscureText: obscure!,
          style: const TextStyle(
            color: CustomColors.secondaryColor,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            fillColor: CustomColors.whiteSecondary,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: CustomColors.primaryColor,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: CustomColors.secondaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xffff1111),
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xffff1111),
                width: 2,
              ),
            ),
            label: Text(labelText),
            labelStyle: GoogleFonts.poppins(
              color: CustomColors.labelColor,
            ),
          ),
        ),
      ),
    );
  }
}
