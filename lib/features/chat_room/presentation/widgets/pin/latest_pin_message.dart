import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';
import 'package:uchat/features/chat_room/presentation/chat_room_presentation.dart';
import 'package:uchat/features/chat_room/presentation/widgets/pin/pin_messages_bottom_sheet.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/effect/blur_box.dart';

class LatestPinMessage extends StatelessWidget {
  const LatestPinMessage({
    super.key,
    required this.pinMessageEntities,
    required this.roomId,
    required this.isAbleToPinMessages,
  });

  final PaginationPayload<PinMessageEntity> pinMessageEntities;
  final String roomId;
  final bool isAbleToPinMessages;

  static const double height = 64;

  @override
  Widget build(BuildContext context) {
    final messages = pinMessageEntities.data?.toList();

    if (messages == null || messages.isEmpty) {
      return const SizedBox.shrink();
    }

    final firstPinMessage = messages.first;

    return GestureDetector(
      onTap: () {
        PinMessagesBottomSheet.show(
          isAbleToPinMessages: isAbleToPinMessages,
          messages: pinMessageEntities,
          roomId: roomId,
        );
      },
      child: BlurBox(
        blurWeight: 15,
        child: Container(
          color: context.theme.appColors.backgroundPinnedBanner.withValues(
            alpha: 0.72,
          ),
          height: height,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.space4,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppText.body4Bold(
                      'Pinned messages (@count)'.trParams({
                        'count': pinMessageEntities.total.toString(),
                      }),
                      context: context,
                      color: context.theme.appColors.textPrimaryInverse,
                    ),
                    const SizedBox(
                      height: AppSpace.space1,
                    ),
                    AppText.body3(
                      firstPinMessage.message?.message?.displayMarkUp(getDisplay: true) ?? '',
                      context: context,
                      color: context.theme.appColors.textPrimaryInverse,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Assets.vectors.chevronForwardIos.svg(
                colorFilter: ColorFilter.mode(
                  context.theme.appColors.iconPrimaryInverse,
                  BlendMode.srcIn,
                ),
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
