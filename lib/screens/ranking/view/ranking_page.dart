import 'package:avatars/avatars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_app/screens/ranking/controller/ranking_controller.dart';
import 'package:tcc_app/utils/custom_colors.dart';
import 'package:tcc_app/widgets/avatar_level.dart';
import 'package:tcc_app/widgets/texts/standart_text.dart';

class RankingPage extends GetView<RankingController> {
  const RankingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: 0,
                  child: AvatarLevel(
                    size: 64,
                    name: state!.first.name ?? '#',
                    level: state.first.level,
                    borderColor: CustomColors.tertiaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 80,
                  child: AvatarLevel(
                    size: 64,
                    name: state[1].name ?? '#',
                    level: state[1].level,
                    borderColor: CustomColors.whiteSecondary,
                    textColor: CustomColors.secondaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 80,
                  child: AvatarLevel(
                    size: 64,
                    name: state[2].name ?? '#',
                    level: state[2].level,
                    borderColor: CustomColors.secondaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: CustomColors.whiteTertiary,
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: state.length,
                itemBuilder: (_, index) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: state[index].clientId ==
                            FirebaseAuth.instance.currentUser!.uid
                        ? CustomColors.tertiaryColor
                        : CustomColors.whiteSecondary,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset:
                            const Offset(2, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Avatar(
                            name: state[index].name ?? '#',
                            shape: AvatarShape.circle(40),
                          ),
                          StandartText(text: state[index].name ?? '#'),
                        ],
                      ),
                      StandartText(text: state[index].level.toString()),
                    ],
                  ),
                ),
                separatorBuilder: (_, index) => const Divider(
                  color: Colors.transparent,
                  height: 8,
                ),
              ),
            ),
          ),
        ],
      ),
      onLoading: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
