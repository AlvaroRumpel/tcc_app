import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_workout/screens/home_personal/controller/home_trainer_controller.dart';
import 'package:play_workout/utils/custom_colors.dart';
import 'package:play_workout/utils/empty_state.dart';
import 'package:play_workout/widgets/buttons/standart_button.dart';
import 'package:play_workout/widgets/client_card_container.dart';
import 'package:play_workout/widgets/standart_scaffold.dart';

class HomeTrainerPage extends GetView<HomeTrainerController> {
  const HomeTrainerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
      appBar: true,
      title: 'Bem-vindo',
      body: EasyRefresh(
        header: ClassicHeader(
          dragText: 'Puxe para atualizar',
          armedText: 'Atualizar',
          processedText: 'Atualizado',
          processingText: 'Atualizando',
          readyText: 'Atualizando',
          textStyle: GoogleFonts.poppins(
            color: CustomColors.whiteStandard,
            fontSize: 16,
          ),
          messageStyle: GoogleFonts.poppins(
            color: CustomColors.whiteStandard,
            fontSize: 16,
          ),
          messageText: 'Ultima atualização as %T',
          iconTheme: const IconThemeData(
            color: CustomColors.whiteStandard,
          ),
          safeArea: true,
        ),
        onRefresh: () async {
          await controller.getData(isRefresh: true);
        },
        child: controller.obx(
          (state) => ListView.builder(
            itemCount: state?.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ClientCardContainer(
                onTap: () => controller.openClientModal(state![index]),
                name: state![index].name,
                goal: state[index].goal,
                hasResponse: state[index].hasResponse,
              ),
            ),
          ),
          onLoading: const Center(
            child: CircularProgressIndicator(),
          ),
          onEmpty: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              children: [
                EmptyState(text: 'Nenhum cliente encontrado'),
                StandartButton(
                  text: 'Recarregar',
                  function: () async {
                    await controller.getData(isRefresh: true);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
