import 'package:avatars/avatars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tcc_app/models/trainer_model.dart';
import 'package:tcc_app/models/user_model.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/utils/utils_widgets.dart';
import 'package:tcc_app/widgets/buttons/standart_button.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/texts/small_text.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';

class HomePersonalPageController extends GetxController {
  List<UserModel> clients = [];
  RxBool isLoading = true.obs;
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    try {
      List clientLists = [];
      var collection = await db
          .collection('trainers')
          .where('personal_id', isEqualTo: (user?.uid ?? ''))
          .get();
      for (var item in collection.docs) {
        clientLists = item.data()['clients'];
      }
      var response = await db
          .collection('clients')
          .where('client_id', whereIn: clientLists)
          .get();
      for (var item in response.docs) {
        clients.add(UserModel.fromMap(item.data()));
      }
      isLoading.toggle();
    } catch (e) {
      isLoading.toggle();
      UtilsWidgets.errorSnackbar(description: e.toString());
    }
  }

  void openClientModal(int index) {
    Get.defaultDialog(
      title: "",
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      radius: 10,
      backgroundColor: CustomColors.whiteStandard,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16.0),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff364151),
                  Color(0xff4D6382),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Avatar(
                      name: clients[index].name.toUpperCase(),
                      shape: AvatarShape.circle(36),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StandartText(
                          text: clients[index].name,
                          color: CustomColors.whiteStandard,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StandartText(
                              text: (clients[index]
                                      .height
                                      .toString()
                                      .substring(0, 1) +
                                  '.' +
                                  clients[index]
                                      .height
                                      .toString()
                                      .substring(1)),
                              color: CustomColors.whiteStandard,
                            ),
                            StandartText(
                              text: clients[index].weight.toString() + ' Kg',
                              color: CustomColors.whiteStandard,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                StandartText(
                  text: 'Nivel ' + clients[index].level.toString(),
                  color: CustomColors.sucessColor,
                ),
                LinearPercentIndicator(
                  barRadius: const Radius.circular(10),
                  backgroundColor: CustomColors.whiteStandard,
                  progressColor: CustomColors.sucessColor,
                  lineHeight: 16,
                  percent: double.parse('0' + clients[index].xp.toString()),
                ),
              ],
            ),
          ),
          StandartButton(text: 'Progresso', function: () {}),
          StandartButton(text: 'Treinos', function: () {}),
          StandartButton(
            text: 'Chat',
            function: () {},
            leadingIcon: FontAwesome.chat_empty,
          ),
        ],
      ),
    );
  }
}
