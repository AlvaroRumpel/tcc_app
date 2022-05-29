import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:tcc_app/utils/custom_colors.dart';

class SvgLogoIcon extends StatelessWidget {
  const SvgLogoIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.only(top: 16.0, right: 24.0),
      child: Icon(
        FontAwesome5.dumbbell,
        size: 96,
        color: CustomColors.primaryColor,
      ),
    );
  }
}
