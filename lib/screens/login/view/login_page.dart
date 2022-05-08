import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/utils/svg_logo_icon.dart';
import 'package:tcc_app/widgets/buttons/standart_back_button.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_textfield.dart';
import 'package:tcc_app/widgets/texts/title_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandardScaffold(
      body: StandartContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon(
            //   FontAwesome5.dumbbell,
            //   color: CustomColors.primaryColor,
            //   size: 72,
            // ),
            SvgLogoIcon(),
            TitleText(text: 'Login'),
            StandartTextfield(
              labelText: 'Usuário',
            ),
          ],
        ),
      ),
    );
  }
}
