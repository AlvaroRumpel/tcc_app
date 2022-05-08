import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tcc_app/firebase_options.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/custom_scaffold.dart';
import 'package:tcc_app/widgets/standart_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: CustomColors.primaryColor,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
