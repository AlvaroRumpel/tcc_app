import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/screens/singup/controller/singup_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/utils/svg_logo_icon.dart';
import 'package:tcc_app/widgets/buttons/google_button.dart';
import 'package:tcc_app/widgets/buttons/standart_back_button.dart';
import 'package:tcc_app/widgets/buttons/standart_button.dart';
import 'package:tcc_app/widgets/buttons/standart_text_button.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';
import 'package:tcc_app/widgets/standart_textfield.dart';
import 'package:tcc_app/widgets/texts/title_text.dart';

class SingupPage extends StatelessWidget {
  SingupPage({Key? key}) : super(key: key);

  SingupController ct = Get.put(SingupController());

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
                controller: ct.userController,
                labelText: 'Usuário',
                validator: ct.validator.userValidator,
                errorText: 'Usuário invalido',
              ),
              StandartTextfield(
                controller: ct.emailController,
                labelText: 'Email',
                validator: ct.validator.emailValidator,
                errorText: 'Email invalido',
              ),
              StandartTextfield(
                controller: ct.passController,
                labelText: 'Senha',
                obscure: true,
                validator: ct.validator.passValidator,
                errorText: 'Senha inválida, no minimo 8 caracteres',
              ),
              StandartButton(
                text: 'Cadastrar como um cliente',
                smallText: true,
                function: () => ct.singup(),
              ),
              StandartTextButton(
                text: 'Cadastrar como um personal',
                function: () => Get.toNamed('/personal-singup'),
              ),
              GoogleButton(function: () => print('object')),
            ],
          ),
        ),
      ),
    );
  }
}
