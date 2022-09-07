import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_workout/routes/routes.dart';
import 'package:play_workout/screens/login/controller/login_controller.dart';
import 'package:play_workout/utils/svg_logo_icon.dart';
import 'package:play_workout/widgets/buttons/standart_button.dart';
import 'package:play_workout/widgets/buttons/standart_outlined_button.dart';
import 'package:play_workout/widgets/buttons/standart_text_button.dart';
import 'package:play_workout/widgets/standart_scaffold.dart';
import 'package:play_workout/widgets/standart_container.dart';
import 'package:play_workout/widgets/standart_textfield.dart';
import 'package:play_workout/widgets/texts/title_text.dart';

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
                function: () => controller.forgotPass(),
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
