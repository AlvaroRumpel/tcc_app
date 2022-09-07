import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_workout/screens/singup_forms/personal/controller/singup_trainer_controller.dart';
import 'package:play_workout/utils/custom_colors.dart';
import 'package:play_workout/utils/empty_state.dart';
import 'package:play_workout/widgets/buttons/standart_back_button.dart';
import 'package:play_workout/widgets/buttons/standart_button.dart';
import 'package:play_workout/widgets/buttons/standart_text_button.dart';
import 'package:play_workout/widgets/standart_container.dart';
import 'package:play_workout/widgets/standart_scaffold.dart';
import 'package:play_workout/widgets/standart_textfield.dart';
import 'package:play_workout/widgets/texts/standart_text.dart';
import 'package:play_workout/widgets/texts/title_text.dart';

class SingupTrainerFormPage extends GetView<SingupTrainerFormController> {
  const SingupTrainerFormPage({Key? key}) : super(key: key);

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
                child: controller.obx(
                  (state) => Stepper(
                    elevation: 0,
                    type: StepperType.horizontal,
                    currentStep: state!,
                    controlsBuilder: (context, _) {
                      return Column(
                        children: <Widget>[
                          StandartButton(
                            function: () => controller.next(),
                            text: 'Seguir',
                          ),
                          StandartTextButton(
                            function: () => controller.back(),
                            text: state > 0 ? 'Voltar' : 'Cancelar',
                          ),
                        ],
                      );
                    },
                    steps: [
                      Step(
                        title: const Padding(padding: EdgeInsets.all(0)),
                        content: const PersonalForm1(),
                        isActive: state == 0,
                        state:
                            state == 0 ? StepState.editing : StepState.complete,
                      ),
                      Step(
                        title: const Padding(padding: EdgeInsets.all(0)),
                        content: const PersonalForm2(),
                        isActive: state == 1,
                        state:
                            state == 1 ? StepState.editing : StepState.complete,
                      ),
                      Step(
                        title: const Padding(padding: EdgeInsets.all(0)),
                        content: const PersonalForm3(),
                        isActive: state == 2,
                        state:
                            state == 2 ? StepState.editing : StepState.indexed,
                      ),
                    ],
                  ),
                  onEmpty: EmptyState(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalForm1 extends GetView<SingupTrainerFormController> {
  const PersonalForm1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StandartText(text: 'Seu nome'),
          StandartTextfield(
            spaced: true,
            labelText: 'Nome',
            hintText: 'Nome',
            validator: controller.validator.isAlphabetic,
            errorText: "Nome inválido",
            controller: controller.nameController,
          ),
          StandartText(text: 'Seu sobrenome'),
          StandartTextfield(
            spaced: true,
            labelText: 'Sobrenome',
            validator: controller.validator.isAlphabetic,
            errorText: "Sobrenome",
            controller: controller.lastNameController,
          ),
          StandartText(text: 'Seu preço semanal'),
          StandartTextfield(
            spaced: true,
            labelText: 'Preço semanal',
            hintText: 'Preço referente a 3 dias',
            validator: controller.validator.isNumber,
            errorText: "Valor inválido",
            controller: controller.priceController,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}

class PersonalForm2 extends GetView<SingupTrainerFormController> {
  const PersonalForm2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StandartText(text: 'Seu celular'),
          StandartTextfield(
            spaced: true,
            labelText: 'Celular',
            hintText: '55999999999',
            validator: controller.validator.isPhone,
            errorText: "Celular inválido",
            controller: controller.phoneController,
            keyboardType: TextInputType.number,
          ),
          StandartText(text: 'Seu CPF'),
          StandartTextfield(
            spaced: true,
            labelText: 'CPF',
            validator: controller.validator.isCPF,
            errorText: "CPF inválido",
            controller: controller.cpfController,
            keyboardType: TextInputType.number,
            hintText: '333.333.333-33',
          ),
          StandartText(text: 'Seu CEP'),
          StandartTextfield(
            spaced: true,
            labelText: 'CEP',
            hintText: '99999-999',
            validator: controller.validator.isCEP,
            errorText: "CEP inválido",
            controller: controller.cepController,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}

class PersonalForm3 extends GetView<SingupTrainerFormController> {
  const PersonalForm3({Key? key}) : super(key: key);

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
            validator: controller.validator.simpleValidation,
            errorText: 'Texto inválido',
            controller: controller.aboutController,
            maxLength: 255,
          ),
          StandartText(text: 'Sua chave de PIX'),
          StandartTextfield(
            labelText: 'Uma chave aleatória de preferência',
            errorText: 'Chave inválida',
            validator: controller.validator.simpleValidation,
            controller: controller.keyController,
            maxLength: 144,
          )
        ],
      ),
    );
  }
}
