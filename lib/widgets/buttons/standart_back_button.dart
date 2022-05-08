import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/utils/custom_colors.dart';

class StandartBackButton extends StatelessWidget {
  const StandartBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const ShapeDecoration(
          color: CustomColors.primaryColor,
          shape: CircleBorder(),
        ),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
          ),
          iconSize: 32,
          color: CustomColors.whiteStandard,
        ),
      ),
    );
  }
}
