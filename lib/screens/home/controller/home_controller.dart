import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/models/enum/user_type.dart';
import 'package:play_workout/models/user_model.dart';
import 'package:play_workout/services/user_service.dart';

class HomeController extends GetxController with StateMixin<UserModel> {
  int currentIndex = 0;
  GlobalController globalController = GlobalController.i;
  double xpPercent = 0;
  RxString pageTitle = 'Bem-vindo'.obs;
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
    var timesGetClient = 0;
    while (globalController.client == null) {
      timesGetClient++;
      if (globalController.client == null || isRefresh) {
        globalController.getClient();
      }
      if (timesGetClient >= 3) {
        UserService.logout();
        return;
      }
    }
    globalController.acceptTerms(UserType.client);
    xpPercent =
        (globalController.client!.xp / globalController.xpNeededForNextLevel());
    xpPercent = xpPercent.isNaN ? 0 : xpPercent;
    change(globalController.client, status: RxStatus.success());
  }

  void nextPage(int index) {
    currentIndex = index;
    switch (index) {
      case 0:
        pageTitle.value = 'Bem-vindo';
        break;
      case 1:
        pageTitle.value = 'Treinadores';
        break;
      case 2:
        pageTitle.value = 'Treinos';
        break;
      case 3:
        pageTitle.value = 'Ranking';
        break;
      default:
        pageTitle.value = 'Bem-vindo';
    }

    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
