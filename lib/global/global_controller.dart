import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:get/get.dart';
import 'package:play_workout/config/database_variables.dart';

import 'package:play_workout/global/global_service.dart';
import 'package:play_workout/models/notification_model.dart';
import 'package:play_workout/models/notifications_list_model.dart';
import 'package:play_workout/models/trainer_model.dart';
import 'package:play_workout/models/trainer_user_model.dart';
import 'package:play_workout/models/training_finished_model.dart';
import 'package:play_workout/models/user_model.dart';
import 'package:play_workout/models/user_trainer_model.dart';
import 'package:play_workout/services/local_storage.dart';
import 'package:play_workout/utils/utils_widgets.dart';

class GlobalController extends GetxController {
  GlobalController({
    required this.service,
  });

  GlobalService service;

  static GlobalController get i => Get.find();

  UserModel? client;
  TrainerModel? trainer;
  List<TrainingFinishedModel> progress = [];
  NotificationsListModel? notifications;
  String notificationDocomentId = '';
  RxBool haveNewNotification = false.obs;

  var androidConfig = const FlutterBackgroundAndroidConfig(
    notificationTitle: "Play Workout",
    notificationText: "O aplicativo está rodando em segundo plano",
    notificationImportance: AndroidNotificationImportance.High,
    notificationIcon:
        AndroidResource(name: 'ic_launcher', defType: 'mipmap-hdpi'),
  );
  @override
  void onInit() async {
    super.onInit();
    await FlutterBackground.initialize(androidConfig: androidConfig);
    isEmailVerified();
  }

  void isEmailVerified() {
    bool? emailVerified = FirebaseAuth.instance.currentUser?.emailVerified;

    if (emailVerified != null && !emailVerified) {
      UtilsWidgets.emailVerifiedSnackbar(
        () async =>
            await FirebaseAuth.instance.currentUser!.sendEmailVerification(),
      );
    }
  }

  Future<void> getClient({String? idClient}) async {
    client = await service.getClient(idClient: idClient);

    if (client == null) return;

    await LocalStorage.setClient(client!);

    TrainerUserModel? trainerUserModel = client!.trainers
        .firstWhereOrNull((element) => element.accepted && element.active);

    if (trainerUserModel != null) {
      trainer = await service.getTrainer(
        idTrainer: trainerUserModel.trainerId,
      );

      if (trainer == null) return;

      await LocalStorage.setTrainer(trainer!);
    }
  }

  Future<void> getTrainer({String? idTrainer}) async {
    trainer = await service.getTrainer(idTrainer: idTrainer);
    if (trainer == null) return;

    await LocalStorage.setTrainer(trainer!);
  }

  Future<void> getHistory({String? idClient}) async {
    progress = await service.getHistory(idClient: idClient) ?? [];
  }

  bool checkLevel(int xpEarned) {
    client!.xp += xpEarned;

    var xpNeeded = xpNeededForNextLevel();
    if (client!.xp >= xpNeeded) {
      client!.level++;
      client!.xp -= xpNeeded;
      return true;
    }
    return false;
  }

  int xpNeededForNextLevel({UserTrainerModel? userTrainerModel}) {
    const exponent = 1.5;
    const baseXp = 250;
    if (userTrainerModel != null) {
      return (baseXp * pow(userTrainerModel.level, exponent)).floor();
    }
    return (baseXp * pow(client!.level, exponent)).floor();
  }

  Future<void> updateTrainer() async {
    if (trainer == null) {
      var trainerId = client!.trainers
          .firstWhereOrNull((element) => element.accepted && element.active)
          ?.trainerId;
      trainer = await service.getTrainer(idTrainer: trainerId);
      return;
    }
    UserTrainerModel? old = trainer!.clients.firstWhereOrNull((element) =>
        element.clientId == FirebaseAuth.instance.currentUser!.uid);
    UserTrainerModel newModel = UserTrainerModel(
      id: old!.id,
      name: client?.name ?? old.name,
      accepted: old.accepted,
      active: old.active,
      birthDate: client!.birthDate,
      bodyFat: client!.bodyFat,
      clientId: client?.clientId ?? old.clientId,
      goal: client?.goal ?? old.goal,
      hasResponse: old.hasResponse,
      height: client?.height ?? old.height,
      level: client!.level,
      sex: old.sex,
      weight: client?.weight ?? old.weight,
      xp: client!.xp,
      fcmToken: client!.fcmToken,
    );

    trainer!.clients[trainer!.clients
        .indexWhere((element) => element.id == newModel.id)] = newModel;
  }

  Future<void> getNotifications() async {
    notifications = await service.getNotifications();
    if (notifications != null && notifications!.id != null) {
      notificationDocomentId = notifications!.id!;
      haveNewNotification.value =
          notifications?.notifications.any((element) => !element.read) ?? false;

      FirebaseFirestore.instance
          .collection(DB.notifications)
          .doc(notificationDocomentId)
          .snapshots()
          .listen(
        (event) {
          notifications =
              NotificationsListModel.fromMap(event.data()!, event.id);
        },
      );
      Timer.periodic(
        const Duration(seconds: 20),
        (timer) {
          haveNewNotification.value =
              notifications?.notifications.any((element) => !element.read) ??
                  false;
        },
      );
    } else {
      haveNewNotification.value = false;
    }
  }

  Future<void> setNotifications({
    required NotificationModel notification,
    required String personId,
  }) async {
    await service.setNotifications(notification, personId);
  }

  Future<void> readNotification({required List<String> notificationIds}) async {
    await service.readNotification(notificationIds);
  }
}
