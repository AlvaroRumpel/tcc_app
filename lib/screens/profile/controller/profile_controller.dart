import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tcc_app/models/user_model.dart';
import 'package:tcc_app/utils/utils_widgets.dart';

class ProfileController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  UserModel? profile;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    try {
      var response = await db
          .collection('clients')
          .where('client_id', isEqualTo: user!.uid)
          .get();
      for (var res in response.docs) {
        profile = UserModel.fromMap(res.data());
      }
      isLoading.toggle();
    } catch (e) {
      print('erro: $e');
      UtilsWidgets.errorSnackbar(title: 'Usuario não encontrado');
    }
  }
}
