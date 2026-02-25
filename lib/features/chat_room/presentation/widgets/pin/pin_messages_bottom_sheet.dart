import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_message_by_ref_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/unpin_all_messages_in_room_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/unpin_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/watch_pin_messages_in_room_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/pin_messages_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/pin/pin_messages_list.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_name_use_case.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class PinMessagesBottomSheet {
  static Future<void> show({
    required PaginationPayload<PinMessageEntity> messages,
    required String roomId,
    required bool isAbleToPinMessages,
  }) async {
    await Get.bottomSheet(
      GetBuilder(
        init: PinMessagesController(
          initialMessages: messages,
          roomId: roomId,
          isAbleToPinMessages: isAbleToPinMessages,
          getContactNameUseCase: GetIt.I<GetContactNameUseCase>(),
          unpinAllMessagesInRoomUseCase: GetIt.I<UnpinAllMessagesInRoomUseCase>(),
          unpinMessageUseCase: GetIt.I<UnpinMessageUseCase>(),
          watchPinMessagesInRoomUseCase: GetIt.I<WatchPinMessagesInRoomUseCase>(),
          getMessageByRefUseCase: GetIt.I<GetMessageByRefUseCase>(),
          log: GetIt.I<LoggerService>(),
        ),
        builder: (_) {
          return const _PinMessages();
        },
      ),
      isScrollControlled: true,
      isDismissible: true,
      ignoreSafeArea: false,
    );
  }
}

class _PinMessages extends GetView<PinMessagesController> {
  const _PinMessages();

  static const double _kButtonSize = 44.0;

  @override
  Widget build(BuildContext context) {
    // use scaffold for show snackbar on bottom sheet
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: context.theme.appColors.elevationSurfaceChat,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(
                AppSpace.space8,
              ),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 36,
                height: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: AppSpace.space2,
                ),
                decoration: BoxDecoration(
                  color: context.theme.appColors.icon.withValues(
                    alpha: 0.3,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppRadius.roundedFull,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsGeometry.symmetric(
                  horizontal: AppSpace.space6,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: _buttonCircle(
                          context: context,
                          child: Assets.vectors.xClose.svg(
                            colorFilter: ColorFilter.mode(
                              context.theme.appColors.iconLighter,
                              BlendMode.srcIn,
                            ),
                          ),
                          onTap: () => Get.back(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Obx(
                          () => AppText.title3(
                            'Pinned (@count)'.trParams({
                              'count': controller.totalMessages.toString(),
                            }),
                            context: context,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: controller.isAbleToPinMessages
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: _buttonCircle(
                                context: context,
                                onTap: () async {
                                  UChatNewDialog.showDialog(
                                    context: context,
                                    title: 'Unpin all messages'.tr,
                                    description:
                                        'This action will unpin all messages in this conversation. Would you like to continue?'
                                            .tr,
                                    confirmText: 'Unpin all'.tr,
                                    confirmTextColor: context.theme.appColors.textError,
                                    onConfirm: () async {
                                      await controller.unpinAllMessages();
                                    },
                                  );
                                },
                                child: Assets.vectors.iconUnpin.svg(
                                  colorFilter: ColorFilter.mode(
                                    context.theme.appColors.iconError,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    )
                  ],
                ),
              ),
              const Expanded(
                child: SafeArea(
                  child: PinMessageList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonCircle({
    required BuildContext context,
    required Widget child,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _kButtonSize,
        height: _kButtonSize,
        decoration: BoxDecoration(
          color: context.theme.appColors.backgroundNeutralLightPressed,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
