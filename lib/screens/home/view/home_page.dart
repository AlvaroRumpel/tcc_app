import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:tcc_app/screens/home/controller/home_controller.dart';
import 'package:tcc_app/screens/profile/view/profile_page.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';

class HomePage extends StatelessWidget {
  HomeController ct = Get.put(HomeController());
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
      appBar: true,
      title: 'Bem-vindo',
      bottomNavigationBar: ConvexAppBar(
        initialActiveIndex: ct.currentIndex.value,
        curveSize: 80,
        style: TabStyle.react,
        activeColor: CustomColors.whiteStandard,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          colors: [
            Color(0x8fE1462D),
            CustomColors.primaryColor,
          ],
        ),
        items: const [
          TabItem(icon: FontAwesome5.home),
          TabItem(icon: Elusive.group),
          TabItem(icon: FontAwesome5.dumbbell),
          TabItem(icon: FontAwesome5.crown),
        ],
        onTap: (value) => ct.currentIndex.value = value,
      ),
      body: Obx(
        () {
          switch (ct.currentIndex.value) {
            case 0:
              return StandartContainer(
                child: Text('aa'),
              );
            default:
              return StandartContainer(
                child: Text('aa'),
              );
          }
        },
      ),
    );
  }
}
