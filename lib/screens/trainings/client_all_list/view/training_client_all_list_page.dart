import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_workout/routes/routes.dart';
import 'package:play_workout/screens/trainings/client_all_list/controller/training_client_all_list_controller.dart';
import 'package:play_workout/utils/custom_colors.dart';
import 'package:play_workout/utils/empty_state.dart';
import 'package:play_workout/widgets/buttons/standart_button.dart';
import 'package:play_workout/widgets/buttons/standart_icon_button.dart';
import 'package:play_workout/widgets/standart_container.dart';

class TrainingClientAllListPage
    extends GetView<TrainingClientAllListController> {
  const TrainingClientAllListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: StandartButton(
                leadingIcon: FontAwesome.chat_empty,
                text: 'Chat',
                function: () async {
                  await Get.toNamed(
                    Routes.toChat,
                    arguments: state!.first,
                  );
                },
              ),
            ),
            EasyRefresh(
              header: ClassicHeader(
                dragText: 'Puxe para atualizar',
                armedText: 'Atualizar',
                processedText: 'Atualizado',
                processingText: 'Atualizando',
                readyText: 'Atualizando',
                textStyle: GoogleFonts.poppins(
                  color: CustomColors.primaryColor,
                  fontSize: 16,
                ),
                messageStyle: GoogleFonts.poppins(
                  color: CustomColors.primaryColor,
                  fontSize: 16,
                ),
                messageText: 'Ultima atualização as %T',
                iconTheme: const IconThemeData(
                  color: CustomColors.primaryColor,
                ),
                safeArea: true,
              ),
              onRefresh: () async {
                await controller.getData();
              },
              child: StandartContainer(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    mainAxisExtent: 250,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: state!.length,
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () => controller.goToTraining(index),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff364151),
                            Color(0xff4D6382),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            state[index].trainings.first.name,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: CustomColors.whiteStandard,
                              fontSize: 32,
                            ),
                          ),
                          StandartIconButton(
                            function: () => controller.goToTraining(index),
                            circle: true,
                          ),
                        ],
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
      onEmpty: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptyState(),
          StandartButton(
            leadingIcon: Icons.refresh_rounded,
            text: 'Atualizar',
            function: () async => await controller.getData(),
          ),
        ],
      ),
    );
  }
}
