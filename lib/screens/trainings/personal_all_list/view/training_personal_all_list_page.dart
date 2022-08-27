import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/screens/trainings/personal_all_list/controller/training_personal_all_list_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/buttons/standart_icon_button.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';

class TrainingPersonalAllListPage
    extends GetView<TrainingPersonalAllListController> {
  const TrainingPersonalAllListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
      appBar: true,
      title: 'Treinos',
      body: StandartContainer(
        child: controller.obx(
          (state) => ListView.builder(
            itemCount: state!.length >= 6 ? state.length : state.length + 1,
            itemBuilder: (_, index) => GestureDetector(
              onTap: () {
                if (index == state.length) {
                  controller.addTraining();
                }
              },
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                      child: index == state.length
                          ? const Icon(
                              Icons.add,
                              color: CustomColors.whiteStandard,
                              size: 40,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(
                                    state[index].trainings.first.name,
                                    style: GoogleFonts.poppins(
                                      color: CustomColors.whiteStandard,
                                      fontSize: 32,
                                    ),
                                  ),
                                ),
                                StandartIconButton(
                                  function: () =>
                                      controller.goingToTraining(index),
                                  circle: true,
                                ),
                              ],
                            ),
                    ),
                  ),
                  if (index != state.length)
                    Positioned(
                      top: -8,
                      right: 0,
                      child: StandartIconButton(
                        function: () => controller.removeTraining(index),
                        circle: true,
                        backgroundColor: CustomColors.errorColor,
                        icon: Icons.remove,
                        size: 32,
                      ),
                    ),
                ],
              ),
            ),
          ),
          onEmpty: GestureDetector(
            onTap: () {
              controller.addTraining();
            },
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
              child: const Icon(
                Icons.add,
                color: CustomColors.whiteStandard,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
