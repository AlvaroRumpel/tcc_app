import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_app/config/commom_config.dart';
import 'package:tcc_app/routes/routes.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;

  @override
  void onInit() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    if (await user.getBool(CommomConfig.isClient) == false) {
      Routes.offToHomePersonal;
    }
    super.onInit();
  }
}
