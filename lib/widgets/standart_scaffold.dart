import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';
import 'package:tcc_app/widgets/texts/title_text.dart';

class StandartScaffold extends StatelessWidget {
  Widget body;
  bool appBar = false;
  String? title;

  Widget? bottomNavigationBar;

  StandartScaffold({
    Key? key,
    required this.body,
    this.appBar = false,
    this.title,
    this.bottomNavigationBar,
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
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Get.offAndToNamed('/login');
                      },
                      icon: Icon(FontAwesome.logout))
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
                ),
                toolbarHeight: 80,
                leadingWidth: 80,
                leading: GestureDetector(
                  onTap: () => Get.offAndToNamed('/home'),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: CustomColors.whiteStandard,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      FontAwesome5.home,
                      color: CustomColors.primaryColor,
                      size: 40,
                    ),
                  ),
                ),
                backgroundColor: const Color(0x00ffffff),
                shadowColor: const Color(0x00ffffff),
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
