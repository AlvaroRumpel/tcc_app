import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:tcc_app/config/database_variables.dart';
import 'package:tcc_app/global/global_controller.dart';
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
  var db = FirebaseFirestore.instance;
  GlobalController globalController = GlobalController.i;

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
    trainingArguments[index].conclude = conclude;
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
    if (time == null || xpEarned == 0) {
      UtilsWidgets.errorSnackbar(
        title: 'Você não iniciou seu treino ou não concluiu um exercicio ainda',
        description:
            'Ainda não começou a treinar, você pode apenas voltar para a pagina anterior',
      );
      return;
    }

    TrainingFinishedModel trainingFinished = TrainingFinishedModel(
      clientId: FirebaseAuth.instance.currentUser?.uid ?? '',
      training: trainingArguments
          .where((element) => element.conclude == true)
          .toList(),
      xpEarned: xpEarned,
      time: time!,
      date: DateTime.now(),
    );

    var hasLevelUp = globalController.checkLevel(xpEarned);
    try {
      await db.collection(DB.historic).add(trainingFinished.toMap());
      await db.collection(DB.clients).doc(globalController.client!.id).set(
            globalController.client!.toMap(),
          );
      for (var i = 0; i < trainingArguments.length; i++) {
        trainingArguments[i].conclude = false;
      }
      if (hasLevelUp) {
        UtilsWidgets.levelUpModal(globalController.client!.level, Get.back);
      } else {
        Get.back();
      }
      UtilsWidgets.sucessSnackbar(
        title: 'Treino finalizado com sucesso',
        description: 'Você acabou seu treino e ganhou $xpEarned xp',
      );
    } catch (e) {
      UtilsWidgets.errorSnackbar();
    }
  }
}
