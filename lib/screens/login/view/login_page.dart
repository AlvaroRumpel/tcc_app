import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/screens/login/controller/login_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/utils/svg_logo_icon.dart';
import 'package:tcc_app/widgets/buttons/google_button.dart';
import 'package:tcc_app/widgets/buttons/standart_back_button.dart';
import 'package:tcc_app/widgets/buttons/standart_button.dart';
import 'package:tcc_app/widgets/buttons/standart_text_button.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_textfield.dart';
import 'package:tcc_app/widgets/texts/title_text.dart';

class LoginPage extends StatelessWidget {
  LoginController ct = Get.put(LoginController());
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
      body: StandartContainer(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SvgLogoIcon(),
              TitleText(text: 'Login'),
              GoogleButton(function: () {}),
              Text(
                'ou',
                style: GoogleFonts.poppins(
                    color: CustomColors.labelColor, fontSize: 24),
              ),
              StandartTextfield(
                controller: ct.emailController,
                labelText: 'Email',
                validator: ct.validator.emailValidator,
                errorText: 'Email inválido',
              ),
              StandartTextfield(
                controller: ct.passController,
                labelText: 'Senha',
                obscure: true,
                validator: ct.validator.passValidator,
                errorText: 'Senha deve conter no minimo 8 caracteres',
              ),
              StandartTextButton(
                dense: true,
                text: 'Esqueci a senha',
                function: () {},
              ),
              StandartButton(
                text: 'Entrar',
                function: () => ct.login(),
              ),
              StandartTextButton(
                text: 'Não tenho conta',
                function: () => Get.toNamed('/cadastro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
