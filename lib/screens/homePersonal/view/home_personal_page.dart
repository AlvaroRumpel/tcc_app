import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/screens/homePersonal/controller/home_personal_page_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/buttons/standart_icon_button.dart';
import 'package:tcc_app/widgets/client_card_container.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';
import 'package:tcc_app/widgets/texts/small_text.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';

class HomePersonalPage extends StatelessWidget {
  HomePersonalPageController ct = Get.put(HomePersonalPageController());
  HomePersonalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
        appBar: true,
        title: 'Bem-vindo',
        body: Obx(
          () => !ct.isLoading.value
              ? ListView.builder(
                  itemCount: ct.clients.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ClientCardContainer(
                      onTap: () => ct.openClientModal(index),
                      name: ct.clients[index].name,
                      goal: ct.clients[index].goal,
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
