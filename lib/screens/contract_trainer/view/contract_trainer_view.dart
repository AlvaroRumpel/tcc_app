import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_app/screens/contract_trainer/controller/contract_trainer_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/utils/empty_state.dart';
import 'package:tcc_app/widgets/trainer_card_container.dart';

class ContractTrainerView extends GetView<ContractTrainerController> {
  ContractTrainerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width) * 0.85,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: controller.searchController.value,
            onChanged: (value) => controller.search(value),
            style: GoogleFonts.poppins(),
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search_outlined),
              fillColor: CustomColors.whiteSecondary,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: CustomColors.primaryColor,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: CustomColors.secondaryColor,
                  width: 2,
                ),
              ),
              hintText: 'Pesquisar',
              hintStyle: GoogleFonts.poppins(
                color: CustomColors.labelColor,
              ),
            ),
          ),
        ),
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
                  id: state[index].trainerId!,
                ),
              ),
            ),
            onLoading: const Center(
              child: CircularProgressIndicator(),
            ),
            onEmpty: EmptyState(),
          ),
        ),
      ],
    );
  }
}
