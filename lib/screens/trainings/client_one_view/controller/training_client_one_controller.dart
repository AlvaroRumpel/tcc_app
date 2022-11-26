import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_workout/utils/custom_colors.dart';
import 'package:play_workout/widgets/buttons/standart_button.dart';
import 'package:play_workout/widgets/buttons/standart_outlined_button.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:play_workout/config/database_variables.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/models/enum/timer_type.dart';
import 'package:play_workout/models/training_finished_model.dart';
import 'package:play_workout/models/training_model.dart';
import 'package:play_workout/utils/utils_widgets.dart';

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

  Future<void> controlTimer({bool? stop}) async {
    if (stop != null && stop) {
      timerIsRunning.value = TimerType.stop;
      time = StopWatchTimer.getDisplayTime(
        timerController.rawTime.value,
        milliSecond: false,
      );
      timerController.onStopTimer();
      await FlutterBackground.disableBackgroundExecution();
      return;
    }
    if (timerIsRunning.value == TimerType.stop) {
      timerController.onResetTimer();
      timerIsRunning.value = TimerType.running;
      timerController.onStartTimer();
      await FlutterBackground.enableBackgroundExecution();
      return;
    }

    if (timerIsRunning.value == TimerType.running ||
        timerIsRunning.value == TimerType.pause) {
      timerIsRunning.value = timerIsRunning.value == TimerType.pause
          ? TimerType.running
          : TimerType.pause;
      timerIsRunning.value == TimerType.pause
          ? timerController.onStopTimer()
          : timerController.onStartTimer();
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
    await globalController.updateTrainer();
    try {
      await db.collection(DB.historic).add(
            trainingFinished.toMap(),
          );
      await db.collection(DB.clients).doc(globalController.client!.id).set(
            globalController.client!.toMap(),
          );
      await db.collection(DB.trainers).doc(globalController.trainer!.id).set(
            globalController.trainer!.toMap(),
          );
      for (var i = 0; i < trainingArguments.length; i++) {
        trainingArguments[i].conclude = false;
      }
      globalController.progress.add(trainingFinished);
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

  Future<bool> canBack() async {
    return await showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        titlePadding: const EdgeInsets.symmetric(vertical: 8),
        titleTextStyle: GoogleFonts.poppins(
          color: CustomColors.primaryColor,
          fontSize: 24,
        ),
        title: const Text(
          'Sair?',
          textAlign: TextAlign.center,
        ),
        content: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Você perderá todo o progresso feito neste treino, tem certeza que deseja sair?',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: CustomColors.primaryColor,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: StandartOutlinedButton(
                      dense: true,
                      smallText: true,
                      text: 'Sim, sair',
                      function: () {
                        FlutterBackground.disableBackgroundExecution();
                        return Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Divider(),
                  ),
                  Expanded(
                    flex: 3,
                    child: StandartButton(
                      dense: true,
                      smallText: true,
                      color: CustomColors.primaryColor,
                      text: 'Não, ficar',
                      function: () => Navigator.of(context).pop(false),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
