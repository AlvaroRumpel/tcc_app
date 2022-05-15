import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tcc_app/screens/singupForms/client/controller/singup_client_form_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/buttons/standart_back_button.dart';
import 'package:tcc_app/widgets/buttons/standart_button.dart';
import 'package:tcc_app/widgets/buttons/standart_text_button.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';
import 'package:tcc_app/widgets/standart_textfield.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';
import 'package:tcc_app/widgets/texts/title_text.dart';
import 'package:date_time_picker/date_time_picker.dart';

class SingupClientFormPage extends StatelessWidget {
  SingupClientFormController ct = Get.put(SingupClientFormController());

  SingupClientFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
      body: StandartContainer(
        child: Theme(
          data: Theme.of(context)
              .copyWith(canvasColor: CustomColors.whiteStandard),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StandartBackButton(),
                  Expanded(
                    child: TitleText(
                      text: 'Insira seus dados',
                      subtitle: true,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Obx(
                  () => Stepper(
                    elevation: 0,
                    type: StepperType.horizontal,
                    currentStep: ct.currentStep.value,
                    controlsBuilder: (context, _) {
                      return Column(
                        children: <Widget>[
                          StandartButton(
                            function: () => ct.next(),
                            text: 'Seguir',
                          ),
                          StandartTextButton(
                            function: () => ct.currentStep.value > 0
                                ? ct.currentStep.value--
                                : Get.back(),
                            text: ct.currentStep.value > 0
                                ? 'Voltar'
                                : 'Cancelar',
                          ),
                        ],
                      );
                    },
                    steps: [
                      Step(
                        title: const Padding(padding: EdgeInsets.all(0)),
                        content: ClientForm1(
                          ct: ct,
                        ),
                        isActive: ct.currentStep.value == 0,
                        state: ct.currentStep.value == 0
                            ? StepState.editing
                            : StepState.complete,
                      ),
                      Step(
                        title: const Padding(padding: EdgeInsets.all(0)),
                        content: ClientForm2(ct: ct),
                        isActive: ct.currentStep.value == 1,
                        state: ct.currentStep.value == 1
                            ? StepState.editing
                            : StepState.indexed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClientForm1 extends StatelessWidget {
  SingupClientFormController ct;
  ClientForm1({
    Key? key,
    required this.ct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StandartText(text: 'Sua altura'),
          StandartTextfield(
            spaced: true,
            labelText: 'Altura',
            hintText: '180 cm',
            validator: ct.validator.isHeight,
            errorText: "Altura inválida",
            controller: ct.heightController,
            keyboardType: TextInputType.number,
          ),
          StandartText(text: 'Seu peso'),
          StandartTextfield(
            spaced: true,
            labelText: 'Peso',
            validator: ct.validator.isWeight,
            errorText: "Peso inválida",
            controller: ct.weightController,
            keyboardType: TextInputType.number,
            hintText: '85 Kg',
          ),
          StandartText(text: 'Sua gordura corporal'),
          StandartTextfield(
            spaced: true,
            labelText: 'Gordura corporal',
            hintText: '20%',
            validator: ct.validator.isBodyFat,
            errorText: "Gordura corporal inválida",
            controller: ct.bodyFatController,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}

class ClientForm2 extends StatelessWidget {
  SingupClientFormController ct;
  ClientForm2({
    Key? key,
    required this.ct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StandartText(text: 'Sexo biológico'),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    StandartText(
                      text: 'Masculino',
                      isLabel: true,
                    ),
                    Radio(
                      value: 1,
                      groupValue: ct.radioValue.value,
                      onChanged: (value) {
                        ct.radioValue.value = 1;
                      },
                      toggleable: true,
                      activeColor: CustomColors.primaryColor,
                    ),
                  ],
                ),
                Column(
                  children: [
                    StandartText(
                      text: 'Feminino',
                      isLabel: true,
                    ),
                    Radio(
                      value: 2,
                      groupValue: ct.radioValue.value,
                      onChanged: (value) {
                        ct.radioValue.value = 2;
                      },
                      toggleable: true,
                      activeColor: CustomColors.primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          StandartText(text: 'Seu objetivo'),
          Padding(
            padding: const EdgeInsets.only(
                top: 8, bottom: 24, left: 16, right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(2, 2), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextDropdownFormField(
                options: ct.objectivos,
                decoration: InputDecoration(
                  fillColor: CustomColors.whiteSecondary,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: CustomColors.primaryColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: CustomColors.secondaryColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xffff1111),
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xffff1111),
                      width: 2,
                    ),
                  ),
                  labelText: 'Objetivo',
                ),
              ),
            ),
          ),
          StandartText(text: 'Data de nascimento'),
          StandartTextfield(
            date: true,
            spaced: true,
            labelText: 'Data de nascimento',
            hintText: 'dd/mm/yyyy',
            validator: () {},
            errorText: 'Data de nascimento inválida',
            controller: ct.dateController,
          ),
        ],
      ),
    );
  }
}
