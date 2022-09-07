import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:play_workout/models/training_model.dart';
import 'package:play_workout/utils/custom_colors.dart';
import 'package:play_workout/utils/validators.dart';
import 'package:play_workout/widgets/buttons/standart_button.dart';
import 'package:play_workout/widgets/buttons/standart_icon_button.dart';
import 'package:play_workout/widgets/standart_textfield.dart';

class TrainingExerciseCard extends StatelessWidget {
  TrainingModel training;
  bool editing;
  TextEditingController? exerciseController;
  TextEditingController? repsController;
  TextEditingController? weightController;
  TextEditingController? seriesController;
  Function? deleteFunction;
  bool isClient;
  Function? concludeFunction;
  Function? cancelFunction;

  TrainingExerciseCard({
    Key? key,
    required this.training,
    this.editing = false,
    this.exerciseController,
    this.repsController,
    this.weightController,
    this.seriesController,
    this.deleteFunction,
    this.isClient = false,
    this.concludeFunction,
    this.cancelFunction,
  }) : super(key: key);

  Validators validators = Validators();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 16,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: CustomColors.containerButton,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: editing
                          ? StandartTextfield(
                              labelText: 'Nome do exercício',
                              validator: validators.simpleValidation,
                              errorText: 'Nome inválido',
                              controller: exerciseController!,
                              fit: true,
                            )
                          : Text(
                              training.training,
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                color: CustomColors.primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Divider(),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: CustomColors.containerButton,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: editing
                          ? StandartTextfield(
                              labelText: 'Reps',
                              validator: validators.isNumber,
                              errorText: 'Numero',
                              controller: repsController!,
                              fit: true,
                              keyboardType: TextInputType.number,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Reps: ',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: CustomColors.primaryColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  training.repetitions.toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    color: CustomColors.primaryColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 12,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: CustomColors.containerButton,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: editing
                        ? StandartTextfield(
                            labelText: 'Carga',
                            validator: validators.isNumber,
                            errorText: 'Numero',
                            controller: weightController!,
                            fit: true,
                            keyboardType: TextInputType.number,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Carga: ',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: CustomColors.primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                training.weight.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  color: CustomColors.primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Kg',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: CustomColors.primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Divider(),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: CustomColors.containerButton,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: editing
                        ? StandartTextfield(
                            labelText: 'Séries',
                            validator: validators.isNumber,
                            errorText: 'Número',
                            controller: seriesController!,
                            fit: true,
                            keyboardType: TextInputType.number,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Series: ',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: CustomColors.primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                training.series.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  color: CustomColors.primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Divider(),
                ),
                Expanded(
                  flex: 6,
                  child: editing
                      ? StandartIconButton(
                          icon: Icons.delete,
                          function: deleteFunction ?? () {},
                          backgroundColor: CustomColors.errorColor,
                        )
                      : StandartIconButton(
                          icon: Icons.info_rounded,
                          function: openInfo,
                        ),
                )
              ],
            ),
            if (isClient && !training.conclude)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 16,
                      child: StandartButton(
                        dense: true,
                        text: 'Concluido',
                        function: concludeFunction!,
                        color: CustomColors.sucessColor,
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Divider(),
                    ),
                    Expanded(
                      flex: 4,
                      child: StandartIconButton(
                        size: 64,
                        function: cancelFunction!,
                        backgroundColor: CustomColors.errorColor,
                        icon: Icons.cancel_outlined,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void openInfo() {
    Get.defaultDialog(
      title: training.training,
      titleStyle: GoogleFonts.poppins(
        color: CustomColors.primaryColor,
      ),
      middleText:
          'Faça ${training.repetitions} repetições durante ${training.series} series com ${training.weight} Kg',
      middleTextStyle: GoogleFonts.poppins(
        color: CustomColors.primaryColor,
        fontSize: 16,
      ),
      radius: 10,
    );
  }
}
