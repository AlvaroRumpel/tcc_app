import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/services/local_storage.dart';

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
}
