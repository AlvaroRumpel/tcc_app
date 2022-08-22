import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:tcc_app/models/enum/timer_type.dart';
import 'package:tcc_app/screens/trainings/client_one_view/controller/training_client_one_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/utils/empty_state.dart';
import 'package:tcc_app/widgets/buttons/standart_button.dart';
import 'package:tcc_app/widgets/buttons/standart_icon_button.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';
import 'package:tcc_app/widgets/training_exercise_card.dart';

class TrainingClientOnePage extends GetView<TrainingClientOneController> {
  TrainingClientOnePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
      appBar: true,
      body: controller.obx(
        (state) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Obx(
                    () => controller.timerIsRunning.value != TimerType.stop
                        ? Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: StandartIconButton(
                                  function: () => controller.controlTimer(),
                                  icon: controller.timerIsRunning.value ==
                                          TimerType.running
                                      ? Icons.pause_circle_outline_rounded
                                      : Icons.play_circle_outline_outlined,
                                  backgroundColor:
                                      controller.timerIsRunning.value ==
                                              TimerType.running
                                          ? CustomColors.secondaryColor
                                          : CustomColors.primaryColor,
                                  size: 88,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: StandartIconButton(
                                  function: () =>
                                      controller.controlTimer(stop: true),
                                  icon: Icons.stop_circle_outlined,
                                  backgroundColor: CustomColors.errorColor,
                                  size: 88,
                                ),
                              ),
                            ],
                          )
                        : StandartIconButton(
                            function: () => controller.controlTimer(),
                            icon: Icons.play_circle_outline_outlined,
                            backgroundColor: CustomColors.sucessColor,
                            size: 88,
                          ),
                  ),
                ),
                StreamBuilder<int>(
                  stream: controller.timerController.rawTime,
                  initialData: controller.timerController.rawTime.value,
                  builder: (_, snap) => Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: CustomColors.containerButton,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: StandartText(
                      text: StopWatchTimer.getDisplayTime(
                        snap.data!,
                        milliSecond: false,
                      ),
                      color: CustomColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state!.length,
                itemBuilder: (_, index) => TrainingExerciseCard(
                  isClient: true,
                  training: state[index],
                  concludeFunction: () => controller.setStatusTraining(
                    index,
                    conclude: true,
                  ),
                  cancelFunction: () => controller.setStatusTraining(
                    index,
                    conclude: false,
                  ),
                ),
              ),
            ),
            StandartButton(
              text: 'Ganhar ${controller.xpEarned} xp',
              function: controller.finishTraining,
            ),
          ],
        ),
        onEmpty: EmptyState(),
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
