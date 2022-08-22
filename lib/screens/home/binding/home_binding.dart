import 'package:get/get.dart';
import 'package:tcc_app/screens/contract_trainer/controller/contract_trainer_controller.dart';
import 'package:tcc_app/screens/home/controller/home_controller.dart';
import 'package:tcc_app/screens/trainings/client_all_list/controller/training_client_all_list_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ContractTrainerController());
    Get.lazyPut(() => TrainingClientAllListController());
  }
}
