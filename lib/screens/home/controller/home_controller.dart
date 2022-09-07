import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/models/user_model.dart';

class HomeController extends GetxController with StateMixin<UserModel> {
  int currentIndex = 0;
  GlobalController globalController = GlobalController.i;
  double xpPercent = 0;
  var user = FirebaseAuth.instance.currentUser;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void onInit() async {
    super.onInit();
    change(state, status: RxStatus.loading());
    await getData();
  }

  Future<void> getData({bool isRefresh = false}) async {
    if (isRefresh) {
      globalController.getClient();
    }
    xpPercent =
        (globalController.client!.xp / globalController.xpNeededForNextLevel());
    xpPercent = xpPercent.isNaN ? 0 : xpPercent;
    change(globalController.client, status: RxStatus.success());
  }

  void nextPage(int index) {
    currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
