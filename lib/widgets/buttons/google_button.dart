import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/utils/custom_colors.dart';

class GoogleButton extends StatelessWidget {
  Function function;
  GoogleButton({
    Key? key,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: CustomColors.containerButton,
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset('assets/google_icon.png', scale: 20),
            ),
            Text(
              'With google',
              style: GoogleFonts.poppins(
                color: CustomColors.blackStandard,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
