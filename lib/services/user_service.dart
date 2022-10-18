import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:play_workout/config/database_variables.dart';
import 'package:play_workout/config/notifications/custom_firebase_messaging.dart';
import 'package:play_workout/global/global_controller.dart';
import 'package:play_workout/models/enum/notification_type.dart';
import 'package:play_workout/models/enum/user_type.dart';
import 'package:play_workout/models/trainer_model.dart';
import 'package:play_workout/models/trainer_user_model.dart';
import 'package:play_workout/models/user_model.dart';
import 'package:play_workout/models/user_trainer_model.dart';
import 'package:play_workout/routes/routes.dart';
import 'package:play_workout/services/local_storage.dart';
import 'package:play_workout/utils/utils_widgets.dart';
import 'package:uuid/uuid.dart';

class UserService {
  static GlobalController globalController = GlobalController.i;

  static Future<UserType> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: GetUtils.removeAllWhitespace(password),
      );

      return checkIsClient();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        message: e.message,
        code: e.code,
      );
    }
  }

  static Future<UserType> checkIsClient() async {
    try {
      await CustomFirebaseMessaging().getTokenFirebase();
      globalController.getNotifications();
      var response = await FirebaseFirestore.instance
          .collection(DB.clients)
          .where('client_id',
              isEqualTo: FirebaseAuth.instance.currentUser?.uid ?? '')
          .get();
      if (response.docs.isNotEmpty) {
        globalController.client = UserModel.fromMap(
          response.docs.first.data(),
          response.docs.first.id,
          fcmToken: await LocalStorage.getFirebaseToken(),
        );
        TrainerUserModel? trainerModel = globalController.client?.trainers
            .firstWhereOrNull((element) => element.accepted && element.active);
        if (trainerModel != null) {
          globalController.getTrainer(idTrainer: trainerModel.trainerId);
        }
        await LocalStorage.setIsClients(true);
        return UserType.client;
      }
      await LocalStorage.setIsClients(false);
      return UserType.trainer;
    } catch (e) {
      await LocalStorage.setIsClients(false);
      return UserType.trainer;
    }
  }

  static Future<void> singup({
    TrainerModel? trainerModel,
    UserModel? userModel,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: await LocalStorage.getEmail(),
        password: await LocalStorage.getPassword(),
      );
      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(await LocalStorage.getUserName());

      await FirebaseAuth.instance.currentUser!.sendEmailVerification();

      await CustomFirebaseMessaging().getTokenFirebase();
      String fcmToken = await LocalStorage.getFirebaseToken() ?? "";

      if (trainerModel != null) {
        trainerModel.trainerId = FirebaseAuth.instance.currentUser?.uid;
        trainerModel.fcmToken = fcmToken;
        await FirebaseFirestore.instance
            .collection(DB.trainers)
            .add(trainerModel.toMap());

        globalController.trainer = trainerModel;

        LocalStorage.setIsClients(false);
      } else if (userModel != null) {
        userModel.clientId = FirebaseAuth.instance.currentUser?.uid;
        userModel.name = await LocalStorage.getUserName();
        userModel.fcmToken = fcmToken;
        await FirebaseFirestore.instance
            .collection(DB.clients)
            .add(userModel.toMap());

        globalController.client = userModel;
        await LocalStorage.setIsClients(true);
        globalController.getNotifications();
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        message: e.message,
        code: e.code,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    globalController.client = null;
    globalController.trainer = null;
    globalController.progress = [];
    globalController.notifications = null;
    await LocalStorage.clearAllData();
    Get.offAllNamed(Routes.toLogin);
  }

  static Future<void> contractTrainer(
    String trainerId,
  ) async {
    UserModel? userModel;
    TrainerModel? trainerModel;
    var uuid = const Uuid();
    try {
      userModel = globalController.client;
      if (userModel!.trainers.any((element) => element.active)) {
        UtilsWidgets.errorSnackbar(
          title: 'Não pode contratar',
          description:
              'Você já possui um personal ativo, não pode ter mais de um',
        );
        return;
      }
      var trainers = await FirebaseFirestore.instance
          .collection(DB.trainers)
          .where(
            'trainer_id',
            isEqualTo: trainerId,
          )
          .get();
      for (var item in trainers.docs) {
        trainerModel = TrainerModel.fromMap(item.data(), item.id);
      }

      TrainerUserModel trainerUserModel = TrainerUserModel(
        id: trainerModel!.id ?? uuid.v4(),
        trainerId: trainerModel.trainerId!,
        firstName: trainerModel.firstName,
        lastName: trainerModel.lastName,
        price: trainerModel.price,
        paymentKey: trainerModel.paymentKey,
        rating: trainerModel.rating,
        active: false,
        accepted: false,
        hasResponse: false,
        fcmToken: trainerModel.fcmToken,
      );

      if (!userModel.trainers.every(
        (element) => element.trainerId != trainerUserModel.trainerId,
      )) {
        UtilsWidgets.errorSnackbar(
          title: 'Não é possivel contratar esse personal',
          description: 'Ele já respondeu sua contratação',
        );
        return;
      }
      userModel.trainers.add(trainerUserModel);

      UserTrainerModel userTrainerModel = UserTrainerModel(
        id: userModel.id ?? uuid.v4(),
        clientId: userModel.clientId!,
        name: userModel.name!,
        bodyFat: userModel.bodyFat,
        goal: userModel.goal,
        height: userModel.height,
        weight: userModel.weight,
        level: userModel.level,
        xp: userModel.xp,
        sex: userModel.sex,
        birthDate: userModel.birthDate,
        active: false,
        accepted: false,
        hasResponse: false,
        fcmToken: userModel.fcmToken,
      );

      trainerModel.clients.add(userTrainerModel);

      await FirebaseFirestore.instance
          .collection(DB.clients)
          .doc(userModel.id)
          .set(
            userModel.toMap(),
            SetOptions(merge: true),
          );
      await FirebaseFirestore.instance
          .collection(DB.trainers)
          .doc(trainerModel.id)
          .set(
            trainerModel.toMap(),
            SetOptions(merge: true),
          );

      globalController.client = userModel;
      globalController.trainer = trainerModel;

      if (trainerModel.fcmToken != null) {
        await CustomFirebaseMessaging().sendNotification(
          to: trainerModel.fcmToken!,
          title: 'Novo cliente!!',
          body:
              '${userModel.name} quer seu treinamento, responda o quanto antes',
          toClient: false,
          notificationType: NotificationType.contract,
          personId: trainerModel.trainerId!,
        );
      }

      Get.back();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> dismissTrainer(
    String trainerId, {
    int timesBack = 1,
  }) async {
    UserModel? userModel;
    TrainerModel? trainerModel;
    try {
      userModel = globalController.client;

      var trainers = await FirebaseFirestore.instance
          .collection(DB.trainers)
          .where(
            'trainer_id',
            isEqualTo: trainerId,
          )
          .get();
      for (var item in trainers.docs) {
        trainerModel = TrainerModel.fromMap(item.data(), item.id);
      }

      for (var element in userModel!.trainers) {
        if (element.trainerId == trainerModel!.trainerId &&
            element.active &&
            element.accepted &&
            element.hasResponse) {
          element.active = false;
        }
      }
      for (var element in trainerModel!.clients) {
        if (element.clientId == userModel.clientId &&
            element.active &&
            element.accepted &&
            element.hasResponse) {
          element.active = false;
        }
      }

      await FirebaseFirestore.instance
          .collection(DB.clients)
          .doc(userModel.id)
          .set(
            userModel.toMap(),
          );

      trainerModel.numberClients--;
      await FirebaseFirestore.instance
          .collection(DB.trainers)
          .doc(trainerModel.id)
          .set(
            trainerModel.toMap(),
          );

      globalController.client = userModel;
      globalController.trainer = trainerModel;
      for (var i = 0; i < timesBack; i++) {
        Get.back();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> responseClient(
    String idClient,
    bool accepted, {
    Function? callback,
  }) async {
    UserModel? userModel;
    TrainerModel? trainerModel;
    var uuid = const Uuid();
    try {
      var users = await FirebaseFirestore.instance
          .collection(DB.clients)
          .where(
            'client_id',
            isEqualTo: idClient,
          )
          .get();
      for (var item in users.docs) {
        userModel = UserModel.fromMap(item.data(), item.id);
      }

      trainerModel = globalController.trainer;

      TrainerUserModel trainerUserModel = TrainerUserModel(
        id: trainerModel!.id ?? uuid.v4(),
        trainerId: trainerModel.trainerId!,
        firstName: trainerModel.firstName,
        lastName: trainerModel.lastName,
        price: trainerModel.price,
        paymentKey: trainerModel.paymentKey,
        rating: trainerModel.rating,
        active: accepted,
        accepted: accepted,
        hasResponse: true,
        fcmToken: trainerModel.fcmToken,
      );

      userModel!.trainers[userModel.trainers.indexWhere(
              (element) => element.trainerId == trainerUserModel.trainerId)] =
          trainerUserModel;

      UserTrainerModel userTrainerModel = UserTrainerModel(
        id: userModel.id ?? uuid.v4(),
        clientId: userModel.clientId!,
        name: userModel.name!,
        bodyFat: userModel.bodyFat,
        goal: userModel.goal,
        height: userModel.height,
        weight: userModel.weight,
        level: userModel.level,
        xp: userModel.xp,
        sex: userModel.sex,
        birthDate: userModel.birthDate,
        active: accepted,
        accepted: accepted,
        hasResponse: true,
        fcmToken: userModel.fcmToken,
      );

      trainerModel.clients[trainerModel.clients.indexWhere(
              (element) => element.clientId == userTrainerModel.clientId)] =
          userTrainerModel;
      trainerModel.numberClients += 1;
      await FirebaseFirestore.instance
          .collection(DB.clients)
          .doc(userModel.id)
          .set(
            userModel.toMap(),
            SetOptions(merge: true),
          );
      await FirebaseFirestore.instance
          .collection(DB.trainers)
          .doc(trainerModel.id)
          .set(
            trainerModel.toMap(),
            SetOptions(merge: true),
          );

      globalController.trainer = trainerModel;
      Get.back();
      callback != null ? callback() : null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> sendRating({
    required double rating,
    required TrainerModel trainer,
  }) async {
    try {
      trainer.numberOfRatings = (trainer.numberOfRatings! + 1);
      trainer.totalOfRatings = (trainer.totalOfRatings! + rating);
      trainer.rating = trainer.totalOfRatings! / trainer.numberOfRatings!;
      await FirebaseFirestore.instance
          .collection(DB.trainers)
          .doc(trainer.id!)
          .set(trainer.toMap());
      Get.back();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
