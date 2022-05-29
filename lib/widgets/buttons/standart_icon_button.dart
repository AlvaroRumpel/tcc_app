import 'package:flutter/material.dart';

import 'package:tcc_app/utils/custom_colors.dart';

class StandartIconButton extends StatelessWidget {
  Function function;
  IconData? icon;
  StandartIconButton({
    Key? key,
    required this.function,
    this.icon = Icons.touch_app_rounded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: CustomColors.primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 0,
              offset: const Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Icon(
          icon,
          color: CustomColors.whiteStandard,
          size: 25,
        ),
      ),
    );
  }
}
