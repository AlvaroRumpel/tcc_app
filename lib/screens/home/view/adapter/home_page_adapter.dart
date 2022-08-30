import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tcc_app/screens/home/controller/home_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';

class HomePageAdapter extends GetView<HomeController> {
  const HomePageAdapter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8.0),
      child: controller.obx(
        (state) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: const Offset(2, 2), // changes position of shadow
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: CustomColors.whiteStandard,
                ),
                child: Row(
                  children: [
                    Avatar(
                      name: controller.user?.displayName?.toUpperCase() ?? '#',
                      border: Border.all(
                        color: CustomColors.sucessColor,
                        width: 4,
                      ),
                      shape: AvatarShape.circle(48),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          StandartText(
                            padding: const EdgeInsets.all(0),
                            text: 'Nivel ${state!.level}',
                            color: CustomColors.sucessColor,
                          ),
                          LinearPercentIndicator(
                            barRadius: const Radius.circular(10),
                            backgroundColor: CustomColors.labelColor,
                            progressColor: CustomColors.sucessColor,
                            animation: true,
                            lineHeight: 16,
                            percent: controller.xpPercent,
                          ),
                          StandartText(
                            padding: const EdgeInsets.only(top: 8),
                            text: ('${state.xp} xp'),
                            color: CustomColors.sucessColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: StandartContainer(
                  alignment: Alignment.topCenter,
                  child: StandartText(
                    padding: const EdgeInsets.all(0),
                    align: TextAlign.center,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    text:
                        'Obrigado por acessar o aplicativo, qualquer problema/dúvida pode me mandar em alvaroRumpel@gmail.com',
                  ),
                ),
              ),
            )
          ],
        ),
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
