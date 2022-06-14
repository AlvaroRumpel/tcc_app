import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/screens/home_personal/controller/home_trainer_controller.dart';
import 'package:tcc_app/utils/empty_state.dart';
import 'package:tcc_app/widgets/client_card_container.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';

class HomeTrainerPage extends GetView<HomeTrainerController> {
  const HomeTrainerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
      appBar: true,
      title: 'Bem-vindo',
      body: controller.obx(
        (state) => ListView.builder(
          itemCount: state?.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ClientCardContainer(
              onTap: () => controller.openClientModal(index),
              name: state![index].name,
              goal: state[index].goal,
            ),
          ),
        ),
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ),
        onEmpty: const EmptyState(),
      ),
    );
  }
}
