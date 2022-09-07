import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_workout/screens/splash/controller/splash_controller.dart';
import 'package:play_workout/utils/svg_logo_icon.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff364151),
            Color(0xff4D6382),
          ],
        ),
      ),
      alignment: Alignment.center,
      child: const SvgLogoIcon(),
    );
  }
}
