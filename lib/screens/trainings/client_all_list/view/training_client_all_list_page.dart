import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/screens/trainings/client_all_list/controller/training_client_all_list_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/utils/empty_state.dart';
import 'package:tcc_app/widgets/buttons/standart_button.dart';
import 'package:tcc_app/widgets/buttons/standart_icon_button.dart';
import 'package:tcc_app/widgets/standart_container.dart';

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
                      Routes.toWhithoutIdChat + state!.trainerId!);
                },
              ),
            ),
            StandartContainer(
              child: Obx(
                () => GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    mainAxisExtent: 250,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: controller.trainings.length,
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
                              controller.trainings[index],
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
                          ]),
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
      onEmpty: EmptyState(),
    );
  }
}
