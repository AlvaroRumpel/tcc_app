import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:play_workout/config/database_variables.dart';
import 'package:play_workout/models/notification_model.dart';
import 'package:play_workout/models/notifications_list_model.dart';
import 'package:play_workout/models/trainer_model.dart';
import 'package:play_workout/models/training_finished_model.dart';
import 'package:play_workout/models/user_model.dart';
import 'package:play_workout/services/local_storage.dart';

class GlobalService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<UserModel?> getClient({String? idClient}) async {
    try {
      var response = await db
          .collection(DB.clients)
          .where('client_id',
              isEqualTo: idClient ?? FirebaseAuth.instance.currentUser?.uid)
          .get();

      String? fcmToken =
          idClient == null || idClient == FirebaseAuth.instance.currentUser?.uid
              ? await LocalStorage.getFirebaseToken()
              : null;

      for (var res in response.docs) {
        return UserModel.fromMap(
          res.data(),
          res.id,
          fcmToken: fcmToken,
        );
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<TrainerModel?> getTrainer({String? idTrainer}) async {
    TrainerModel? model;
    try {
      var response = await db
          .collection(DB.trainers)
          .where('trainer_id',
              isEqualTo: idTrainer ?? FirebaseAuth.instance.currentUser?.uid)
          .get();

      String? fcmToken = idTrainer == null ||
              idTrainer == FirebaseAuth.instance.currentUser?.uid
          ? await LocalStorage.getFirebaseToken()
          : null;

      for (var res in response.docs) {
        model = TrainerModel.fromMap(
          res.data(),
          res.id,
          fcmToken: fcmToken,
        );
      }
      return model;
    } catch (e) {
      return null;
    }
  }

  Future<List<TrainingFinishedModel>?> getHistory({String? idClient}) async {
    List<TrainingFinishedModel> historic = [];
    try {
      var response = await db
          .collection(DB.historic)
          .where(
            'client_id',
            isEqualTo: idClient ?? FirebaseAuth.instance.currentUser?.uid ?? '',
          )
          .orderBy('date', descending: false)
          .get();
      if (response.docs.isEmpty) {
        return null;
      }
      for (var item in response.docs) {
        historic.add(TrainingFinishedModel.fromMap(item.data(), item.id));
      }
      return historic;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<NotificationsListModel?> getNotifications() async {
    NotificationsListModel? notifications;
    try {
      var response = await db
          .collection(DB.notifications)
          .where('person_id',
              isEqualTo: FirebaseAuth.instance.currentUser?.uid ?? '')
          .get();

      if (response.docs.isEmpty) {
        return notifications;
      }
      for (var item in response.docs) {
        notifications = NotificationsListModel.fromMap(item.data(), item.id);
      }
      return notifications;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return notifications;
    }
  }

  Future<bool> setNotifications(
      NotificationModel notification, String personId) async {
    try {
      var response = await db
          .collection(DB.notifications)
          .where('person_id', isEqualTo: personId)
          .get();
      if (response.docs.isEmpty) {
        await db.collection(DB.notifications).add(
              NotificationsListModel(
                      notifications: [notification], personId: personId)
                  .toMap(),
            );
        return true;
      }

      NotificationsListModel? notificationsList;
      for (var item in response.docs) {
        notificationsList =
            NotificationsListModel.fromMap(item.data(), item.id);
      }
      notificationsList!.notifications.add(notification);
      await db.collection(DB.notifications).doc(notificationsList.id!).set(
            notificationsList.toMap(),
            SetOptions(merge: true),
          );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<void> readNotification(List<String> notificationIds) async {
    try {
      if (notificationIds.isEmpty) {
        return;
      }
      NotificationsListModel? notifications;
      var response = await db
          .collection(DB.notifications)
          .where(
            'person_id',
            isEqualTo: FirebaseAuth.instance.currentUser?.uid ?? '',
          )
          .get();
      for (var item in response.docs) {
        notifications = NotificationsListModel.fromMap(item.data(), item.id);
      }
      for (var item in notifications!.notifications) {
        if (notificationIds.contains(item.id)) {
          item.read = true;
        }
      }
      await db.collection(DB.notifications).doc(notifications.id).set(
            notifications.toMap(),
            SetOptions(merge: true),
          );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> updateTerms({
    UserModel? client,
    TrainerModel? trainer,
  }) async {
    try {
      if (client != null) {
        client.termsAccepted = true;
        await db.collection(DB.clients).doc(client.id).set(
              client.toMap(),
              SetOptions(merge: true),
            );
        return;
      }
      if (trainer != null) {
        trainer.termsAccepted = true;
        await db.collection(DB.trainers).doc(trainer.id).set(
              trainer.toMap(),
              SetOptions(merge: true),
            );
        return;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
