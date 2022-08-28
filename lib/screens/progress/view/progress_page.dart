import 'package:easy_refresh/easy_refresh.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tcc_app/screens/progress/controller/progress_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';

class ProgressPage extends GetView<ProgressController> {
  const ProgressPage({Key? key}) : super(key: key);

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
          clamping: true,
        ),
        onRefresh: () async {
          await controller.getData(isRefresh: true);
        },
        child: SingleChildScrollView(
          child: controller.obx(
            (state) => Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
              child: Column(
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
                            offset: const Offset(
                                2, 2), // changes position of shadow
                          ),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: CustomColors.whiteStandard,
                      ),
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StandartContainer(
                        isReactive: true,
                        child: StandartText(
                          padding: const EdgeInsets.all(0),
                          text:
                              ('${state.height.toString().substring(0, 1)}.${state.height.toString().substring(1)} m'),
                        ),
                      ),
                      StandartContainer(
                        isReactive: true,
                        child: StandartText(
                          padding: const EdgeInsets.all(0),
                          text: ('${state.weight} kg'),
                        ),
                      ),
                      StandartContainer(
                        isReactive: true,
                        child: StandartText(
                          padding: const EdgeInsets.all(0),
                          text: ('BF ${state.bodyFat}%'),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                      child: Column(
                        children: [
                          StandartText(
                            text: 'Dias treinados',
                          ),
                          TableCalendar(
                            headerVisible: false,
                            eventLoader: (day) {
                              return controller.eventLoader(day);
                            },
                            availableCalendarFormats: const {
                              CalendarFormat.month: 'Month'
                            },
                            calendarStyle: CalendarStyle(
                              markersMaxCount: 4,
                              markerDecoration: const BoxDecoration(
                                color: CustomColors.secondaryColor,
                                shape: BoxShape.circle,
                              ),
                              defaultTextStyle: GoogleFonts.poppins(
                                fontSize: 16,
                              ),
                              todayTextStyle: GoogleFonts.poppins(
                                fontSize: 16,
                                color: CustomColors.whiteStandard,
                              ),
                              todayDecoration: const BoxDecoration(
                                color: CustomColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            currentDay: DateTime.now(),
                            focusedDay: DateTime.now(),
                            firstDay: DateTime.utc(DateTime.now().year, 1, 1),
                            lastDay: DateTime.utc(
                                DateTime.now().year, DateTime.now().month, 31),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: Get.height * 0.5,
                      width: Get.width * 0.9,
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
                                spots: controller.historic,
                              ),
                            ],
                            lineTouchData: LineTouchData(
                              touchTooltipData: LineTouchTooltipData(
                                tooltipBgColor: CustomColors.primaryColor,
                                getTooltipItems: (data) {
                                  return data.map(
                                    (e) {
                                      return LineTooltipItem(
                                          'XP ${e.y.toInt()}',
                                          GoogleFonts.poppins(
                                            color: CustomColors.whiteStandard,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '\n ${DateFormat('dd/MM/yyyy').format(controller.progress[e.spotIndex].date)}',
                                              style: GoogleFonts.poppins(
                                                color: CustomColors
                                                    .whiteStandard
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                          ]);
                                    },
                                  ).toList();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onLoading: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
