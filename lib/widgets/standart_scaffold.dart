import 'package:flutter/material.dart';

class StandardScaffold extends StatelessWidget {
  Widget body;

  StandardScaffold({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff364151),
            Color(0xff4D6382),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: body,
        ),
      ),
    );
  }
}
