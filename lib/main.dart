import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/firebase_options.dart';
import 'package:tcc_app/global/global_binding.dart';
import 'package:tcc_app/routes/routes.dart';
import 'package:tcc_app/screens/chat/binding/chat_binding.dart';
import 'package:tcc_app/screens/chat/view/chat_page.dart';
import 'package:tcc_app/screens/home/binding/home_binding.dart';
import 'package:tcc_app/screens/home/view/home_page.dart';
import 'package:tcc_app/screens/home_personal/binding/home_trainer_binding.dart';
import 'package:tcc_app/screens/home_personal/view/home_trainer_page.dart';
import 'package:tcc_app/screens/login/binding/login_binding.dart';
import 'package:tcc_app/screens/login/view/login_page.dart';
import 'package:tcc_app/screens/profile/binding/profile_binding.dart';
import 'package:tcc_app/screens/profile/view/profile_page.dart';
import 'package:tcc_app/screens/profile_personal/binding/profile_personal_binding.dart';
import 'package:tcc_app/screens/profile_personal/view/profile_personal_page.dart';
import 'package:tcc_app/screens/progress/binding/progress_binding.dart';
import 'package:tcc_app/screens/progress/view/progress_page.dart';
import 'package:tcc_app/screens/singup/binding/singup_binding.dart';
import 'package:tcc_app/screens/singup/view/singup_page.dart';
import 'package:tcc_app/screens/singup_forms/client/binding/singup_client_form_binding.dart';
import 'package:tcc_app/screens/singup_forms/client/view/singup_client_form_page.dart';
import 'package:tcc_app/screens/singup_forms/personal/binding/singup_trainer_form_binding.dart';
import 'package:tcc_app/screens/singup_forms/personal/view/singup_trainer_form_page.dart';
import 'package:tcc_app/screens/splash/binding/splash_binding.dart';
import 'package:tcc_app/screens/splash/view/splash_page.dart';
import 'package:tcc_app/screens/trainings/client_one_view/binding/training_client_one_binding.dart';
import 'package:tcc_app/screens/trainings/client_one_view/view/training_client_one_page.dart';
import 'package:tcc_app/screens/trainings/personal_all_list/binding/training_personal_all_list_binding.dart';
import 'package:tcc_app/screens/trainings/personal_all_list/view/training_personal_all_list_page.dart';
import 'package:tcc_app/screens/trainings/personal_one_view/binding/training_personal_one_binding.dart';
import 'package:tcc_app/screens/trainings/personal_one_view/view/training_personal_one_page.dart';
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
      title: 'Training App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: CustomColors.primaryColor,
      ),
      initialRoute: Routes.toSplash,
      initialBinding: GlobalBinding(),
      getPages: [
        GetPage(
          name: Routes.toSplash,
          page: () => const SplashPage(),
          binding: SplashBinding(),
          preventDuplicates: true,
          children: [
            GetPage(
              name: Routes.toHomeClient,
              page: () => const HomePage(),
              binding: HomeBinding(),
            ),
            GetPage(
              name: Routes.toHomeTrainer,
              page: () => const HomeTrainerPage(),
              binding: HomeTrainerBinding(),
            ),
            GetPage(
              name: Routes.toLogin,
              page: () => const LoginPage(),
              binding: LoginBinding(),
            ),
            GetPage(
              name: Routes.toSingUp,
              page: () => const SingupPage(),
              binding: SingupBinding(),
            ),
            GetPage(
              name: Routes.toClientSingUp,
              page: () => const SingupClientFormPage(),
              binding: SingupClientFormBinding(),
            ),
            GetPage(
              name: Routes.toTrainerSingUp,
              page: () => const SingupTrainerFormPage(),
              binding: SingupTrainerFormBinding(),
            ),
            GetPage(
              name: Routes.toClientProfile,
              page: () => const ProfilePage(),
              binding: ProfileBinding(),
            ),
            GetPage(
              name: Routes.toChat,
              page: () => const ChatPage(),
              binding: ChatBinding(),
            ),
            GetPage(
              name: Routes.toTrainingPersonalAllList,
              page: () => const TrainingPersonalAllListPage(),
              binding: TrainingPersonalAllListBinding(),
            ),
            GetPage(
              name: Routes.toTrainingPersonalOne,
              page: () => const TrainingPersonalOnePage(),
              binding: TrainingPersonalOneBinding(),
            ),
            GetPage(
              name: Routes.toTrainingClientOne,
              page: () => TrainingClientOnePage(),
              binding: TrainingClientOneBinding(),
            ),
            GetPage(
              name: Routes.toProgressClient,
              page: () => const ProgressPage(),
              binding: ProgressBinding(),
            ),
            GetPage(
                name: Routes.toPersonalProfile,
                page: () => ProfilePersonalPage(),
                binding: ProfilePersonalBinding()),
          ],
        ),
      ],
    );
  }
}
