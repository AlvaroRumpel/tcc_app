import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/routes/routes.dart';
import 'package:play_workout/services/local_storage.dart';
import 'package:play_workout/services/user_service.dart';
import 'package:play_workout/utils/custom_colors.dart';

class StandartScaffold extends StatelessWidget {
  Widget body;
  bool appBar = false;
  IconData iconAppBar;
  String? title;

  Widget? bottomNavigationBar;

  StandartScaffold({
    Key? key,
    required this.body,
    this.appBar = false,
    this.title,
    this.bottomNavigationBar,
    this.iconAppBar = Icons.person_outline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Scaffold(
        bottomNavigationBar: bottomNavigationBar,
        appBar: appBar
            ? AppBar(
                actions: [
                  Obx(
                    () => IconButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      iconSize: 24,
                      onPressed: () => Get.toNamed(Routes.toNotifications),
                      color: CustomColors.whiteStandard,
                      icon: GlobalController.i.haveNewNotification.isTrue
                          ? const Icon(Icons.notifications_active)
                          : const Icon(Icons.notifications_none),
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    iconSize: 24,
                    onPressed: () => Get.toNamed(Routes.toChatList),
                    color: CustomColors.whiteStandard,
                    icon: const Icon(FontAwesome.chat_empty),
                  ),
                ],
                title: Align(
                  alignment: Alignment.center,
                  child: Text(
                    title ?? '',
                  ),
                ),
                titleTextStyle: GoogleFonts.poppins(
                  color: CustomColors.whiteStandard,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  backgroundColor: Colors.transparent,
                ),
                toolbarHeight: 60,
                leadingWidth: 60,
                leading: GestureDetector(
                  onTap: () async => await LocalStorage.getIsClients()
                      ? Get.toNamed(Routes.toClientProfile)
                      : Get.toNamed(Routes.toPersonalProfile),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      color: CustomColors.whiteStandard,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      iconAppBar,
                      color: CustomColors.primaryColor,
                      size: 32,
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              )
            : null,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: body,
        ),
      ),
    );
  }
}
