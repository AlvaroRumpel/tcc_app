import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/services/user_service.dart';
import 'package:tcc_app/utils/custom_colors.dart';

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
                  IconButton(
                      padding: const EdgeInsets.all(16),
                      iconSize: 32,
                      onPressed: () => UserService.logout(),
                      color: CustomColors.whiteStandard,
                      icon: const Icon(Icons.logout)),
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
                  onTap: () => bottomNavigationBar != null
                      ? Get.toNamed(Routes.toClientProfile)
                      : Get.offAndToNamed(Routes.toHomeTrainer),
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
