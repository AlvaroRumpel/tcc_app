import 'package:flutter/material.dart';
import 'package:avatars/avatars.dart';
import 'package:get/get.dart';
import 'package:tcc_app/screens/profile/controller/profile_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';
import 'package:tcc_app/widgets/texts/small_text.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: controller.obx(
            ((state) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Avatar(
                        name: (controller.user?.displayName ?? '#'),
                        border: Border.all(
                          color: CustomColors.sucessColor,
                          width: 4,
                        ),
                        shape: AvatarShape.circle(100),
                      ),
                    ),
                    StandartContainer(
                      isReactive: true,
                      child: StandartText(
                        text: (controller.user?.displayName ?? '#'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StandartContainer(
                          isReactive: true,
                          child: StandartText(
                            text:
                                ('${state?.height.toString().substring(0, 1) ?? '?'}.${state?.height.toString().substring(1) ?? '?'} m'),
                          ),
                        ),
                        StandartContainer(
                          isReactive: true,
                          child: StandartText(
                            text: ('${state?.weight.toString() ?? '?'} kg'),
                          ),
                        ),
                      ],
                    ),
                    StandartContainer(
                      isReactive: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText(text: 'Objetivo:'),
                          SmallText(
                            text: state?.goal ?? 'Desconhecido',
                            color: CustomColors.primaryColor,
                            bigger: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            onLoading: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
