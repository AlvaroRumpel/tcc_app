import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:tcc_app/screens/trainings/personal_one_view/controller/training_personal_one_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/utils/validators.dart';
import 'package:tcc_app/widgets/buttons/standart_button.dart';
import 'package:tcc_app/widgets/buttons/standart_icon_button.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';
import 'package:tcc_app/widgets/standart_textfield.dart';
import 'package:tcc_app/widgets/training_exercise_card.dart';

class TrainingPersonalOnePage extends GetView<TrainingPersonalOneController> {
  const TrainingPersonalOnePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
      appBar: true,
      title: controller.trainingArguments.trainings.first.name,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => controller.edit.value == false
                ? StandartButton(
                    text: 'Editar',
                    function: () => controller.changeToEdit(),
                    leadingIcon: FontAwesome.edit,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: StandartIconButton(
                                icon: Icons.check,
                                function: () => controller.saveEdit(),
                                backgroundColor: CustomColors.sucessColor,
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Divider(),
                            ),
                            Expanded(
                              flex: 3,
                              child: StandartIconButton(
                                icon: Icons.cancel_rounded,
                                function: () => controller.cancelEdit(),
                                backgroundColor: CustomColors.errorColor,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
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
                            child: StandartTextfield(
                              fit: true,
                              labelText: controller
                                  .trainingArguments.trainings.first.name,
                              validator: Validators().isAlphabetic,
                              errorText: 'Nome inválido',
                              controller: controller.trainingNameController,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          Expanded(
            child: controller.obx(
              (state) => ListView.builder(
                itemCount: state!.trainings.length,
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      Obx(
                        () => Column(
                          children: [
                            TrainingExerciseCard(
                              training: state.trainings[index],
                              editing: controller.edit.value,
                              exerciseController:
                                  controller.exerciseController[index],
                              repsController: controller.repsController[index],
                              weightController:
                                  controller.weightController[index],
                              seriesController:
                                  controller.seriesController[index],
                              deleteFunction: () =>
                                  controller.removeExercise(index),
                            ),
                            if (controller.edit.value == true &&
                                state.trainings.length == index + 1)
                              GestureDetector(
                                onTap: controller.addExercise,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    color: CustomColors.whiteStandard,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: CustomColors.primaryColor,
                                    size: 40,
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
