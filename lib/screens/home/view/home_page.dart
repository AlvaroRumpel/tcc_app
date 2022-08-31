import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:tcc_app/screens/contract_trainer/view/contract_trainer_view.dart';
import 'package:tcc_app/screens/home/controller/home_controller.dart';
import 'package:tcc_app/screens/home/view/adapter/home_page_adapter.dart';
import 'package:tcc_app/screens/ranking/view/ranking_page.dart';
import 'package:tcc_app/screens/trainings/client_all_list/view/training_client_all_list_page.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
      appBar: true,
      title: 'Bem-vindo',
      bottomNavigationBar: ConvexAppBar(
        initialActiveIndex: controller.currentIndex,
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
        onTap: (value) => controller.nextPage(value),
      ),
      body: PageView(
        pageSnapping: false,
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          const HomePageAdapter(),
          ContractTrainerView(),
          const TrainingClientAllListPage(),
          const RankingPage(),
        ],
      ),
    );
  }
}
