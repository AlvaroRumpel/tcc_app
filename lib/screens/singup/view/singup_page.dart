import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/screens/singup/controller/singup_controller.dart';
import 'package:tcc_app/utils/svg_logo_icon.dart';
import 'package:tcc_app/widgets/buttons/google_button.dart';
import 'package:tcc_app/widgets/buttons/standart_back_button.dart';
import 'package:tcc_app/widgets/buttons/standart_button.dart';
import 'package:tcc_app/widgets/buttons/standart_outlined_button.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';
import 'package:tcc_app/widgets/standart_textfield.dart';
import 'package:tcc_app/widgets/texts/title_text.dart';

class SingupPage extends GetView<SingupController> {
  const SingupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
      body: StandartContainer(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: StandartBackButton(),
              ),
              const SvgLogoIcon(),
              TitleText(text: 'Cadastro'),
              StandartTextfield(
                controller: controller.userController,
                labelText: 'Usuário',
                validator: controller.validator.userValidator,
                errorText: 'Usuário invalido',
              ),
              StandartTextfield(
                controller: controller.emailController,
                labelText: 'Email',
                validator: controller.validator.emailValidator,
                errorText: 'Email invalido',
              ),
              StandartTextfield(
                controller: controller.passController,
                labelText: 'Senha',
                obscure: true,
                validator: controller.validator.passValidator,
                errorText: 'Senha inválida, no minimo 8 caracteres',
              ),
              StandartButton(
                text: 'Cadastrar como um cliente',
                smallText: true,
                function: () => controller.singup(),
              ),
              StandartOutlinedButton(
                text: 'Cadastrar como um personal',
                function: () => controller.singup(isPersonal: true),
              ),
              // GoogleButton(function: () => print('object')),
            ],
          ),
        ),
      ),
    );
  }
}
