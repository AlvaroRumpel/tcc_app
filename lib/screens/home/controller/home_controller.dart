import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_app/config/commom_config.dart';
import 'package:tcc_app/routes/routes.dart';

class HomeController extends GetxController {
  int currentIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void nextPage(int index) {
    currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences user = await SharedPreferences.getInstance();
    if (user.getBool(CommomConfig.isClient) == false) {
      Get.offAndToNamed(Routes.toHomeTrainer);
    }
  }
}
