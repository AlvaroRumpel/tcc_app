import 'package:flutter/material.dart';

import 'package:tcc_app/utils/custom_colors.dart';

class StandartIconButton extends StatelessWidget {
  Function function;
  IconData? icon;
  bool circle;
  Color backgroundColor;
  bool isOutlined;
  double size;
  StandartIconButton({
    Key? key,
    required this.function,
    this.icon = Icons.touch_app_rounded,
    this.circle = false,
    this.backgroundColor = CustomColors.primaryColor,
    this.isOutlined = false,
    this.size = 56,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: circle
                ? Colors.black.withOpacity(0)
                : Colors.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 0,
            offset: const Offset(2, 2), // changes position of shadow
          ),
        ],
        borderRadius:
            circle ? null : const BorderRadius.all(Radius.circular(10)),
      ),
      child: ElevatedButton(
        onPressed: () => function(),
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (states) => backgroundColor,
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (states) {
              Color color =
                  isOutlined ? CustomColors.whiteStandard : backgroundColor;
              if (states.contains(MaterialState.pressed)) {
                return color.withOpacity(0.8);
              }
              if (states.contains(MaterialState.selected)) {
                return color.withOpacity(0.6);
              }
              if (states.contains(MaterialState.dragged)) {
                return color.withOpacity(0.4);
              }
              return color;
            },
          ),
          shape: circle
              ? MaterialStateProperty.resolveWith<CircleBorder?>(
                  (state) => CircleBorder(
                    side: BorderSide(color: backgroundColor),
                  ),
                )
              : MaterialStateProperty.resolveWith<RoundedRectangleBorder?>(
                  (state) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: backgroundColor,
                      width: 2,
                    ),
                  ),
                ),
          padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
            (states) => EdgeInsets.all(size / 8),
          ),
        ),
        child: Icon(
          icon,
          size: size / 2,
          color: isOutlined
              ? CustomColors.primaryColor
              : CustomColors.whiteStandard,
        ),
      ),
    );
  }
}
