import 'package:get/get.dart';
import 'package:play_workout/screens/contract_trainer/controller/contract_trainer_controller.dart';
import 'package:play_workout/screens/home/controller/home_controller.dart';
import 'package:play_workout/screens/ranking/controller/ranking_controller.dart';
import 'package:play_workout/screens/trainings/client_all_list/controller/training_client_all_list_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ContractTrainerController());
    Get.lazyPut(() => TrainingClientAllListController());
    Get.lazyPut(() => RankingController());
  }
}
