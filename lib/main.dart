import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tcc_app/firebase_options.dart';
import 'package:tcc_app/screens/home/view/home_page.dart';
import 'package:tcc_app/screens/login/view/login_page.dart';
import 'package:tcc_app/screens/singup/view/singup_page.dart';
import 'package:tcc_app/screens/singupForms/client/view/singup_client_form_page.dart';
import 'package:tcc_app/screens/singupForms/personal/view/singup_personal_form_page.dart';
import 'package:tcc_app/utils/custom_colors.dart';

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: CustomColors.primaryColor,
      ),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/login' : '/home',
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
        ),
        GetPage(
          name: '/cadastro',
          page: () => SingupPage(),
        ),
        GetPage(
          name: '/client-singup',
          page: () => SingupClientFormPage(),
        ),
        GetPage(
          name: '/personal-singup',
          page: () => SingupPersonalFormPage(),
        )
      ],
    );
  }
}
