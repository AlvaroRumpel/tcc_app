// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:play_workout/utils/custom_colors.dart';
import 'package:play_workout/widgets/texts/standart_text.dart';

class EmptyState extends StatelessWidget {
  bool withContainer;
  String text;
  IconData icon;

  EmptyState({
    Key? key,
    this.withContainer = true,
    this.text = 'Dados não encontrados no sistema',
    this.icon = Typicons.warning_empty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(16),
        decoration: withContainer
            ? BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(2, 2),
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: CustomColors.whiteStandard,
              )
            : null,
        child: Column(
          children: [
            Icon(
              icon,
              color: CustomColors.primaryColor,
              size: 48,
            ),
            StandartText(
              text: text,
              align: TextAlign.center,
              fontSize: 24,
            ),
          ],
        ),
      ),
    );
  }
}
