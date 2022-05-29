import 'package:flutter/material.dart';
import 'package:avatars/avatars.dart';
import 'package:get/get.dart';
import 'package:tcc_app/screens/profile/controller/profile_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/standart_container.dart';
import 'package:tcc_app/widgets/standart_scaffold.dart';
import 'package:tcc_app/widgets/texts/small_text.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';

class ProfilePage extends StatelessWidget {
  ProfileController ct = Get.put(ProfileController());
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandartScaffold(
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Obx(
            (() => ct.isLoading.value
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Avatar(
                          name: (ct.user?.displayName ?? '#'),
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
                          text: (ct.user?.displayName ?? '#'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StandartContainer(
                            isReactive: true,
                            child: StandartText(
                              text: ((ct.profile?.height
                                          .toString()
                                          .substring(0, 1) ??
                                      '?') +
                                  '.' +
                                  (ct.profile?.height.toString().substring(1) ??
                                      '?') +
                                  ' m'),
                            ),
                          ),
                          StandartContainer(
                            isReactive: true,
                            child: StandartText(
                              text: ((ct.profile?.weight.toString() ?? '?') +
                                  ' kg'),
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
                              text: ct.profile?.goal ?? 'Desconhecido',
                              color: CustomColors.primaryColor,
                              bigger: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )),
          ),
        ),
      ),
    );
  }
}
