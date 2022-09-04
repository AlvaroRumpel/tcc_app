import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tcc_app/config/database_variables.dart';
import 'package:tcc_app/models/user_model.dart';

class RankingController extends GetxController
    with StateMixin<List<UserModel>> {
  var db = FirebaseFirestore.instance;
  List<UserModel> users = [];
  @override
  void onInit() async {
    super.onInit();
    change(state, status: RxStatus.loading());
    await getData();
  }

  Future<void> getData() async {
    try {
      var response = await db.collection(DB.clients).get();
      for (var item in response.docs) {
        users.add(UserModel.fromMap(item.data(), item.id));
      }
      users.sort(
        (a, b) => b.level.compareTo(a.level) == 0
            ? b.xp.compareTo(a.xp)
            : b.level.compareTo(a.level),
      );
      change(users, status: RxStatus.success());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
