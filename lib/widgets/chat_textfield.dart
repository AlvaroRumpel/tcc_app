import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:play_workout/utils/custom_colors.dart';

class ChatTextfield extends StatelessWidget {
  TextEditingController controller;
  TextInputType? keyboardType;
  String? hintText;

  ChatTextfield({
    Key? key,
    required this.controller,
    this.keyboardType = TextInputType.name,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
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
          maxLength: 255,
          maxLines: 1,
          keyboardType: keyboardType,
          controller: controller,
          style: GoogleFonts.poppins(
            color: CustomColors.secondaryColor,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            counterText: '',
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
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              color: CustomColors.labelColor,
            ),
            errorStyle: GoogleFonts.poppins(
              color: CustomColors.errorColor,
            ),
          ),
        ),
      ),
    );
  }
}
