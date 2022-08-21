import 'package:flutter/material.dart';

class CustomColors {
  static const MaterialColor primaryColor = MaterialColor(
    0xffE1462D, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffE1462D), //10%
      100: Color(0xffE1462D), //20%
      200: Color(0xffE1462D), //30%
      300: Color(0xffE1462D), //40%
      400: Color(0xffE1462D), //50%
      500: Color(0xffE1462D), //60%
      600: Color(0xffE1462D), //70%
      700: Color(0xffE1462D), //80%
      800: Color(0xffE1462D), //90%
      900: Color(0xffE1462D), //100%
    },
  );
  static const Color whiteStandard = Color(0xffF6F6F6);
  static const Color blackStandard = Color(0xff364151);
  static const Color blackSecondary = Color(0xff1D192B);
  static const Color secondaryColor = Color(0xffEA9E42);
  static const Color tertiaryColor = Color(0xffEDDF84);
  static const Color labelColor = Color(0xffBCBCBC);
  static const Color whiteSecondary = Color(0xffF0F0F0);
  static const Color containerButton = Color(0xffECECEC);
  static const Color errorColor = Color(0xFFFF2A08);
  static const Color sucessColor = Color(0xff4DB38A);
  static const Color sentMessage = Color(0xBBE1462D);
  static const Color reciviedMessage = Color(0xBBEA9E42);
}
