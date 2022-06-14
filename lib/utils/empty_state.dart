import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
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
        ),
        child: Column(
          children: [
            const Icon(
              Typicons.warning_empty,
              color: CustomColors.primaryColor,
              size: 48,
            ),
            StandartText(
              text: 'Dados não encontrados no sistema',
              align: TextAlign.center,
              fontSize: 24,
            ),
          ],
        ),
      ),
    );
  }
}
