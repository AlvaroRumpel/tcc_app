import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/screens/singup_forms/client/controller/singup_client_form_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/utils/empty_state.dart';
import 'package:tcc_app/widgets/buttons/standart_back_button.dart';
import 'package:tcc_app/widgets/buttons/standart_button.dart';
import 'package:tcc_app/widgets/buttons/standart_text_button.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';
import 'package:tcc_app/widgets/standart_textfield.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';
import 'package:tcc_app/widgets/texts/title_text.dart';

class SingupClientFormPage extends GetView<SingupClientFormController> {
  const SingupClientFormPage({Key? key}) : super(key: key);

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
                        content: const ClientForm1(),
                        isActive: state == 0,
                        state:
                            state == 0 ? StepState.editing : StepState.complete,
                      ),
                      Step(
                        title: const Padding(padding: EdgeInsets.all(0)),
                        content: const ClientForm2(),
                        isActive: state == 1,
                        state:
                            state == 1 ? StepState.editing : StepState.indexed,
                      ),
                    ],
                  ),
                  onLoading: const Center(
                    child: CircularProgressIndicator(),
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

class ClientForm1 extends GetView<SingupClientFormController> {
  const ClientForm1({Key? key}) : super(key: key);

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
            validator: controller.validator.isHeight,
            errorText: "Altura inválida",
            controller: controller.heightController,
            keyboardType: TextInputType.number,
          ),
          StandartText(text: 'Seu peso'),
          StandartTextfield(
            spaced: true,
            labelText: 'Peso',
            validator: controller.validator.isWeight,
            errorText: "Peso inválida",
            controller: controller.weightController,
            keyboardType: TextInputType.number,
            hintText: '85 Kg',
          ),
          StandartText(text: 'Sua gordura corporal'),
          StandartTextfield(
            spaced: true,
            labelText: 'Gordura corporal',
            hintText: '20%',
            validator: controller.validator.isBodyFat,
            errorText: "Gordura corporal inválida",
            controller: controller.bodyFatController,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}

class ClientForm2 extends GetView<SingupClientFormController> {
  const ClientForm2({Key? key}) : super(key: key);

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
                      groupValue: controller.radioValue.value,
                      onChanged: (value) {
                        controller.radioValue.value = 1;
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
                      groupValue: controller.radioValue.value,
                      onChanged: (value) {
                        controller.radioValue.value = 2;
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
                controller: controller.objectiveController,
                options: controller.objectives,
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
            controller: controller.dateController,
          ),
        ],
      ),
    );
  }
}
