import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/screens/contract_trainer/controller/contract_trainer_controller.dart';
import 'package:tcc_app/utils/empty_state.dart';
import 'package:tcc_app/widgets/trainer_card_container.dart';

class ContractTrainerView extends StatelessWidget {
  var controller = Get.put(ContractTrainerController());
  ContractTrainerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: controller.obx(
            (state) => ListView.builder(
              itemCount: state?.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TrainerCardContainer(
                  onTap: () => controller.openTrainerModal(index),
                  name: state![index].firstName,
                  price: state[index].price,
                  rating: state[index].rating,
                  numberClients: state[index].numberClients,
                ),
              ),
            ),
            onLoading: const Center(
              child: CircularProgressIndicator(),
            ),
            onEmpty: const EmptyState(),
          ),
        ),
      ],
    );
  }
}
