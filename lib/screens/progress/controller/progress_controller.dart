import 'dart:collection';

import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/models/training_finished_model.dart';
import 'package:play_workout/models/user_model.dart';

class ProgressController extends GetxController with StateMixin<UserModel> {
  GlobalController globalController = GlobalController.i;
  UserModel? client;
  double xpPercent = 0;
  List<TrainingFinishedModel> progress = [];
  List<FlSpot> historic = [];
  double maxX = 0;
  double maxY = 0;
  var events = LinkedHashMap(
    equals: isSameDay,
  );

  @override
  void onInit() {
    super.onInit();
    change(state, status: RxStatus.loading());
    getData();
  }

  Future<void> getData({isRefresh = false}) async {
    if (isRefresh) {
      await globalController.getClient(idClient: client?.clientId);
      await globalController.getHistory(idClient: client?.clientId);
    }
    if ((globalController.client == null ||
                globalController.progress.isEmpty) &&
            Get.arguments != null ||
        globalController.client!.clientId != Get.arguments) {
      await globalController.getClient(idClient: Get.arguments);
      await globalController.getHistory(idClient: Get.arguments);
    }
    client = globalController.client;
    xpPercent = (client!.xp / globalController.xpNeededForNextLevel());
    progress = globalController.progress;
    await getHistory();
    change(client, status: RxStatus.success());
  }

  List<dynamic> eventLoader(DateTime day) {
    return progress
        .where((element) =>
            element.date.day == day.day &&
            element.date.month == day.month &&
            element.date.year == day.year)
        .toList();
  }

  Future<void> getHistory() async {
    historic.clear();
    maxX = progress.length.toDouble() - 1;
    maxY = 0;

    for (var i = 0; i < progress.length; i++) {
      maxY = progress[i].xpEarned.toDouble() > maxY
          ? progress[i].xpEarned.toDouble()
          : maxY;
      historic.add(
        FlSpot(
          i.toDouble(),
          progress[i].xpEarned.toDouble(),
        ),
      );
    }
    maxY += 100;
  }
}
