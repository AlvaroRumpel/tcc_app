import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/screens/login/controller/login_controller.dart';
import 'package:tcc_app/utils/svg_logo_icon.dart';
import 'package:tcc_app/widgets/buttons/google_button.dart';
import 'package:tcc_app/widgets/buttons/standart_button.dart';
import 'package:tcc_app/widgets/buttons/standart_outlined_button.dart';
import 'package:tcc_app/widgets/buttons/standart_text_button.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_textfield.dart';
import 'package:tcc_app/widgets/texts/title_text.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

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
              // GoogleButton(function: () {}),
              // Text(
              //   'ou',
              //   style: GoogleFonts.poppins(
              //       color: CustomColors.labelColor, fontSize: 24),
              // ),
              StandartTextfield(
                controller: controller.emailController,
                labelText: 'Email',
                validator: controller.validator.emailValidator,
                errorText: 'Email inválido',
              ),
              StandartTextfield(
                controller: controller.passController,
                labelText: 'Senha',
                obscure: true,
                validator: controller.validator.passValidator,
                errorText: 'Senha deve conter no minimo 8 caracteres',
              ),
              StandartTextButton(
                dense: true,
                text: 'Esqueci a senha',
                function: () {},
              ),
              StandartButton(
                text: 'Entrar',
                function: () => controller.login(),
              ),
              StandartOutlinedButton(
                text: 'Criar uma conta',
                function: () => Get.toNamed(Routes.toSingUp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
