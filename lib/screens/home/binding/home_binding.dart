import 'package:get/get.dart';
import 'package:play_workout/screens/contract_trainer/controller/contract_trainer_controller.dart';
import 'package:play_workout/screens/home/controller/home_controller.dart';
import 'package:play_workout/screens/ranking/controller/ranking_controller.dart';
import 'package:play_workout/screens/trainings/client_all_list/controller/training_client_all_list_controller.dart';
import 'package:play_workout/screens/trainings/client_all_list/service/training_client_all_list_service.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ContractTrainerController());
    Get.put(TrainingClientAllListService());
    Get.lazyPut(
      () => TrainingClientAllListController(
        service: TrainingClientAllListService(),
      ),
    );
    Get.lazyPut(() => RankingController());
  }
}
