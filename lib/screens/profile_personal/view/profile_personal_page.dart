import 'package:avatars/avatars.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_workout/screens/profile_personal/controller/profile_personal_controller.dart';
import 'package:play_workout/services/user_service.dart';
import 'package:play_workout/utils/custom_colors.dart';
import 'package:play_workout/utils/empty_state.dart';
import 'package:play_workout/widgets/buttons/standart_button.dart';
import 'package:play_workout/widgets/standart_container.dart';
import 'package:play_workout/widgets/standart_scaffold.dart';
import 'package:play_workout/widgets/texts/price_text.dart';
import 'package:play_workout/widgets/texts/standart_text.dart';

class ProfilePersonalPage extends GetView<ProfilePersonalController> {
  const ProfilePersonalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: controller.obx(
            (state) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Avatar(
                  name: '${state!.firstName} ${state.lastName}'.toUpperCase(),
                  shape: AvatarShape.circle(100),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: RatingBarIndicator(
                    itemSize: 32,
                    itemCount: 5,
                    rating: state.rating,
                    itemBuilder: ((context, index) => const Icon(
                          Icons.star,
                          color: CustomColors.tertiaryColor,
                        )),
                  ),
                ),
                StandartContainer(
                  isReactive: true,
                  child: StandartText(
                    text: '${state.firstName} ${state.lastName}',
                  ),
                ),
                StandartContainer(
                  isReactive: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StandartText(
                        text: 'Quem sou',
                        isLabel: true,
                      ),
                      StandartText(
                        text: state.about,
                        color: CustomColors.blackStandard,
                      ),
                    ],
                  ),
                ),
                StandartContainer(
                  isReactive: true,
                  child: PriceText(
                    fontSize: 40,
                    text:
                        '${state.price.toString().split('.')[0]},${state.price.toString().split('.')[1]}',
                  ),
                ),
                StandartContainer(
                  isReactive: true,
                  child: StandartText(text: state.phone.toString()),
                ),
                StandartContainer(
                  isReactive: true,
                  child: StandartText(text: controller.user?.email ?? '#'),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset:
                            const Offset(2, 2), // changes position of shadow
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: CustomColors.whiteStandard,
                  ),
                  child: Column(
                    children: [
                      StandartText(text: 'Chave de pagamento'),
                      StandartText(
                        isSelectable: true,
                        text: state.paymentKey,
                        color: CustomColors.blackStandard,
                      ),
                    ],
                  ),
                ),
                StandartContainer(
                  isReactive: true,
                  child: Column(
                    children: [
                      StandartText(
                        text: 'Treina atualmente',
                        isLabel: true,
                      ),
                      StandartText(text: '${state.numberClients} pessoa'),
                    ],
                  ),
                ),
                StandartButton(
                  text: 'Sair',
                  finalIcon: Icons.logout_outlined,
                  function: () => UserService.logout(),
                ),
              ],
            ),
            onEmpty: EmptyState(),
            onLoading: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
