import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tcc_app/screens/singupForms/client/controller/singup_client_form_controller.dart';
import 'package:tcc_app/screens/singupForms/personal/controller/singup_personal_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/buttons/standart_back_button.dart';
import 'package:tcc_app/widgets/buttons/standart_button.dart';
import 'package:tcc_app/widgets/buttons/standart_text_button.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';
import 'package:tcc_app/widgets/standart_textfield.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';
import 'package:tcc_app/widgets/texts/title_text.dart';

class SingupPersonalFormPage extends StatelessWidget {
  SingupPersonalFormController ct = Get.put(SingupPersonalFormController());

  SingupPersonalFormPage({Key? key}) : super(key: key);

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
                        content: PersonalForm1(
                          ct: ct,
                        ),
                        isActive: ct.currentStep.value == 0,
                        state: ct.currentStep.value == 0
                            ? StepState.editing
                            : StepState.complete,
                      ),
                      Step(
                        title: const Padding(padding: EdgeInsets.all(0)),
                        content: PersonalForm2(ct: ct),
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

class PersonalForm1 extends StatelessWidget {
  SingupPersonalFormController ct;
  PersonalForm1({
    Key? key,
    required this.ct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StandartText(text: 'Seu celular'),
          StandartTextfield(
            spaced: true,
            labelText: 'Celular',
            hintText: '55999857941',
            validator: ct.validator.isPhone,
            errorText: "Celular inválido",
            controller: ct.phoneController,
            keyboardType: TextInputType.number,
          ),
          StandartText(text: 'Seu CPF'),
          StandartTextfield(
            spaced: true,
            labelText: 'CPF',
            validator: ct.validator.isCPF,
            errorText: "CPF inválido",
            controller: ct.cpfController,
            keyboardType: TextInputType.number,
            hintText: '333.333.333-33',
          ),
          StandartText(text: 'Sua CEP'),
          StandartTextfield(
            spaced: true,
            labelText: 'CEP',
            hintText: '99999-999',
            validator: ct.validator.isCEP,
            errorText: "CEP inválido",
            controller: ct.cepController,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}

class PersonalForm2 extends StatelessWidget {
  SingupPersonalFormController ct;
  PersonalForm2({
    Key? key,
    required this.ct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StandartText(
            text: 'Fale um pouco sobre você',
            align: TextAlign.center,
          ),
          StandartTextfield(
            textBox: true,
            labelText: 'Fale um pouco sobre você, para saberem quem você é',
            validator: ct.validator.simpleValidation,
            errorText: 'Texto inválido',
            controller: ct.aboutController,
          ),
          StandartText(text: 'Sua chave de PIX'),
          StandartTextfield(
            labelText: 'Uma chave aleatória de preferência',
            errorText: 'Chave inválida',
            validator: ct.validator.simpleValidation,
            controller: ct.keyController,
          )
        ],
      ),
    );
  }
}
