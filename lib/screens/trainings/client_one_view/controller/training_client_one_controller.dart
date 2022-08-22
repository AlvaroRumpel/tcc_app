import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:tcc_app/models/enum/timer_type.dart';
import 'package:tcc_app/models/training_finished_model.dart';
import 'package:tcc_app/models/training_model.dart';
import 'package:tcc_app/utils/utils_widgets.dart';

class TrainingClientOneController extends GetxController
    with StateMixin<List<TrainingModel>> {
  StopWatchTimer timerController = StopWatchTimer();
  List<TrainingModel> trainingArguments = Get.arguments ?? [];
  Rx<TimerType> timerIsRunning = TimerType.stop.obs;
  String? time;
  int xpEarned = 0;

  @override
  void onInit() {
    super.onInit();
    change(
      trainingArguments,
      status: trainingArguments.isEmpty ? RxStatus.empty() : RxStatus.success(),
    );
  }

  void setStatusTraining(int index, {required bool conclude}) {
    if (timerIsRunning.value != TimerType.running) {
      UtilsWidgets.errorSnackbar(
        title: 'O treino está parado',
        description:
            'O treino precisa estar em play para você poder ${conclude ? 'concluir' : 'cancelar'} um exercício',
      );
      return;
    }
    trainingArguments[index].active = false;
    if (conclude) {
      xpEarned += 50;
    }
    change(trainingArguments, status: RxStatus.success());
  }

  void controlTimer({bool? stop}) {
    if (stop != null && stop) {
      timerIsRunning.value = TimerType.stop;
      time = StopWatchTimer.getDisplayTime(
        timerController.rawTime.value,
        milliSecond: false,
      );
      timerController.onExecute.add(StopWatchExecute.stop);
      return;
    }

    if (timerIsRunning.value == TimerType.stop) {
      timerController.onExecute.add(StopWatchExecute.reset);
      timerIsRunning.value = TimerType.running;
      timerController.onExecute.add(StopWatchExecute.start);
      return;
    }

    if (timerIsRunning.value == TimerType.running ||
        timerIsRunning.value == TimerType.pause) {
      timerIsRunning.value = timerIsRunning.value == TimerType.pause
          ? TimerType.running
          : TimerType.pause;
      timerController.onExecute.add(
        timerIsRunning.value == TimerType.pause
            ? StopWatchExecute.stop
            : StopWatchExecute.start,
      );
      return;
    }
  }

  Future<void> finishTraining() async {
    TrainingFinishedModel trainingFinished = TrainingFinishedModel(
      training: trainingArguments,
      xpEarned: xpEarned,
      time: time!,
    );
    print(trainingFinished);
  }
}
