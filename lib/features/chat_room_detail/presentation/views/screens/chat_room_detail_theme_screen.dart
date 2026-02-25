import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_theme_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/room_detail_app_bar.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';

class ChatRoomDetailThemeScreen extends GetView<ChatRoomDetailThemeController> {
  final String roomTag = Get.parameters['id'] ?? 'NEW_ROOM';

  ChatRoomDetailThemeScreen({super.key});

  @override
  String? get tag => roomTag;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLight,
      appBar: RoomDetailAppBar(
        titleText: 'Theme'.tr,
        isSecret: false,
        action: () {
          controller.onDonePressed();
        },
        actionText: 'Done'.tr,
        actionTextColors: context.theme.appColors.textPrimary,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space4,
        ),
        width: Get.width,
        // color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpace.space4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      blurRadius: 10, // Blur intensity
                      spreadRadius: 4, // Spread radius
                      offset: const Offset(0, 5), // Shadow position
                    ),
                  ],
                ),
                child: Obx(() {
                  return controller.selected.value == 1
                      ? SvgPicture.asset(
                          'assets/vectors/theme_white.svg',
                          width: Get.height * 0.4,
                          height: Get.height * 0.4,
                        )
                      : controller.selected.value == 2
                          ? SvgPicture.asset(
                              'assets/vectors/theme_primary.svg',
                              width: Get.height * 0.4,
                              height: Get.height * 0.4,
                            )
                          : controller.selected.value == 3
                              ? SvgPicture.asset(
                                  'assets/vectors/theme_black.svg',
                                  width: Get.height * 0.4,
                                  height: Get.height * 0.4,
                                )
                              : Container();
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Obx(() {
                      return IconButton(
                        icon: controller.selected.value == 1
                            ? Assets.vectors.iconThemeWhiteSelected.svg()
                            : Assets.vectors.iconThemeWhite.svg(),
                        iconSize: 100,
                        onPressed: () {
                          controller.selected.value = 1;
                        },
                      );
                    }),
                  ),
                  Expanded(
                    child: Obx(() {
                      return IconButton(
                        icon: controller.selected.value == 2
                            ? Assets.vectors.iconThemePrimarySelected.svg()
                            : Assets.vectors.iconThemePrimary.svg(),
                        iconSize: 100,
                        onPressed: () {
                          controller.selected.value = 2;
                        },
                      );
                    }),
                  ),
                  Expanded(
                    child: Obx(() {
                      return IconButton(
                        icon: controller.selected.value == 3
                            ? Assets.vectors.iconThemeDarkSelected.svg()
                            : Assets.vectors.iconThemeDark.svg(),
                        iconSize: 100,
                        onPressed: () {
                          controller.selected.value = 3;
                        },
                      );
                    }),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
