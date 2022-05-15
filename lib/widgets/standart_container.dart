import 'package:flutter/material.dart';
import 'package:tcc_app/utils/custom_colors.dart';

class StandartContainer extends StatelessWidget {
  Widget child;
  Alignment? alignment;
  bool isReactive = false;
  StandartContainer({
    Key? key,
    this.alignment = Alignment.topCenter,
    required this.child,
    this.isReactive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isReactive
          ? FittedBox(
              child: Container(
                margin: const EdgeInsets.all(8),
                alignment: alignment,
                padding: const EdgeInsets.all(16),
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
                child: child,
              ),
            )
          : Container(
              alignment: alignment,
              padding: const EdgeInsets.all(16),
              height: (MediaQuery.of(context).size.height) * 0.85,
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
              child: child,
            ),
    );
  }
}
