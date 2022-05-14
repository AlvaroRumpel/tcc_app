import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  const SingupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandardScaffold(
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
                labelText: 'Usuário',
              ),
              StandartTextfield(
                labelText: 'Senha',
                obscure: true,
              ),
              StandartTextfield(
                labelText: 'Confirmar a senha',
                obscure: true,
              ),
              StandartButton(
                text: 'Cadastrar',
                function: () {},
              ),
              StandartTextButton(
                text: 'Cadastrar como um personal',
                function: () => Get.toNamed('/cadastro'),
              ),
              GoogleButton(function: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
