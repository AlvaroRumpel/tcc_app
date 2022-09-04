import 'package:easy_refresh/easy_refresh.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/screens/profile/controller/profile_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/utils/empty_state.dart';
import 'package:tcc_app/widgets/avatar_level.dart';
import 'package:tcc_app/widgets/buttons/standart_icon_button.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';
import 'package:tcc_app/widgets/texts/small_text.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';
import 'package:tcc_app/widgets/trainer_card_container.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
      body: EasyRefresh(
        header: ClassicHeader(
          dragText: 'Puxe para atualizar',
          armedText: 'Atualizar',
          processedText: 'Atualizado',
          processingText: 'Atualizando',
          readyText: 'Atualizando',
          textStyle: GoogleFonts.poppins(
            color: CustomColors.whiteStandard,
            fontSize: 16,
          ),
          messageStyle: GoogleFonts.poppins(
            color: CustomColors.whiteStandard,
            fontSize: 16,
          ),
          messageText: 'Ultima atualização as %T',
          iconTheme: const IconThemeData(
            color: CustomColors.whiteStandard,
          ),
          safeArea: true,
        ),
        onRefresh: () async {
          await controller.getData(isRefresh: true);
        },
        child: SingleChildScrollView(
          child: controller.obx(
            ((state) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8, top: 8),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: StandartIconButton(
                          circle: true,
                          icon: Icons.refresh_outlined,
                          function: () async {
                            await controller.getData(isRefresh: true);
                          },
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: AvatarLevel(
                          name: controller.user?.displayName ?? '#',
                          level: state!.level,
                          size: 100,
                        )),
                    StandartContainer(
                      isReactive: true,
                      child: StandartText(
                        text: (controller.user?.displayName ?? '#'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StandartContainer(
                          isReactive: true,
                          child: StandartText(
                            text:
                                ('${state.height.toString().substring(0, 1)}.${state.height.toString().substring(1)} m'),
                          ),
                        ),
                        StandartContainer(
                          isReactive: true,
                          child: StandartText(
                            text: ('${state.weight.toString()} kg'),
                          ),
                        ),
                      ],
                    ),
                    StandartContainer(
                      isReactive: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText(text: 'Objetivo:'),
                          SmallText(
                            text: state.goal,
                            color: CustomColors.primaryColor,
                            bigger: true,
                          ),
                        ],
                      ),
                    ),
                    if (controller.trainerComplete != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TrainerCardContainer(
                          onTap: controller.openTrainerModal,
                          name: controller.trainerComplete?.firstName ??
                              'Desconhecido',
                          numberClients:
                              controller.trainerComplete?.numberClients ?? 0,
                          price: controller.trainerComplete?.price ?? 0,
                          rating: controller.trainerComplete?.rating ?? 0,
                          id: controller.trainerComplete?.trainerId ?? '',
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            height: Get.height * 0.35,
                            width: Get.width * 0.85,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: const Offset(
                                      2, 2), // changes position of shadow
                                ),
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: CustomColors.whiteStandard,
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: LineChart(
                                LineChartData(
                                    gridData: FlGridData(show: false),
                                    titlesData: FlTitlesData(show: false),
                                    borderData: FlBorderData(show: false),
                                    minX: 0,
                                    minY: 0,
                                    maxX: controller.maxX,
                                    maxY: controller.maxY,
                                    lineBarsData: [
                                      LineChartBarData(
                                        color: CustomColors.primaryColor,
                                        isCurved: true,
                                        barWidth: 2,
                                        dotData: FlDotData(show: true),
                                        belowBarData: BarAreaData(
                                          show: true,
                                          gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              CustomColors.primaryColor,
                                              CustomColors.secondaryColor,
                                            ],
                                          ),
                                        ),
                                        spots: controller.progress,
                                      ),
                                    ],
                                    lineTouchData: LineTouchData(
                                      touchTooltipData: LineTouchTooltipData(
                                        tooltipBgColor:
                                            CustomColors.primaryColor,
                                        getTooltipItems: (data) {
                                          return data.map((e) {
                                            return LineTooltipItem(
                                                'XP ${e.y.toInt()}',
                                                GoogleFonts.poppins(
                                                  color: CustomColors
                                                      .whiteStandard,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        '\n ${DateFormat('dd/MM/yyyy').format(controller.historic[e.spotIndex].date)}',
                                                    style: GoogleFonts.poppins(
                                                      color: CustomColors
                                                          .whiteStandard
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ]);
                                          }).toList();
                                        },
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          StandartIconButton(
                            function: () =>
                                Get.toNamed(Routes.toProgressClient),
                            icon: Icons.arrow_forward,
                            circle: true,
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            onLoading: const Center(
              child: CircularProgressIndicator(),
            ),
            onEmpty: EmptyState(),
          ),
        ),
      ),
    );
  }
}
