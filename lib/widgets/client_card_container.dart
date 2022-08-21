import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/texts/small_text.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';

class ClientCardContainer extends StatelessWidget {
  Alignment? alignment;
  Function onTap;
  String name;
  String goal;
  bool hasResponse;
  ClientCardContainer({
    Key? key,
    this.alignment = Alignment.topCenter,
    required this.onTap,
    required this.goal,
    required this.name,
    required this.hasResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Center(
        child: Container(
          alignment: alignment,
          padding: const EdgeInsets.all(16),
          width: (MediaQuery.of(context).size.width) * 0.85,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 0,
                offset: const Offset(2, 2), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: CustomColors.whiteStandard,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Visibility(
                visible: !hasResponse,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SmallText(
                    color: CustomColors.whiteStandard,
                    textAlignment: TextAlign.right,
                    text: 'Aguardando Resposta',
                    backgroundColor: CustomColors.primaryColor,
                  ),
                ),
              ),
              Avatar(
                name: name.toUpperCase(),
                shape: AvatarShape.circle(48),
              ),
              StandartText(text: name),
              SmallText(
                text: goal,
                bigger: true,
                backgroundColor: CustomColors.tertiaryColor,
                textAlignment: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
