import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/message_call_type.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/call/domain/params/start_call_param.dart';
import 'package:uchat/features/call/domain/user_cases/start_call_use_case.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention_helper.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/get_name.dart';
import 'package:uchat/widgets/app_text.dart';

class MessageTypeCallV2 extends StatelessWidget {
  final MessageCollection message;

  const MessageTypeCallV2({
    super.key,
    required this.message,
  });

  String get name {
    final accountId = message.callMessage?.payload?.accountId;
    String name = '';
    if (UserController.instance.currentUser()?.id == accountId) {
      name = 'You'.tr;
    } else {
      name = getNameHelper(
        id: accountId,
        fallback: message.displayName,
      );
    }
    return name;
  }

  String? get user => UserController.instance.currentUser()?.id;

  @override
  Widget build(BuildContext context) {
    switch (message.callMessage?.type) {
      case MessageCallType.start:
        return _callStartGroup(context);
      case MessageCallType.end:
        if (message.callMessage?.payload?.isJoined != true) {
          return _missedCallGroup(context);
        }
        return _callEnd(context);
      case MessageCallType.join:
        return _systemMessage(
          context,
          '@name joined the group call'.trParams(
            {'name': '&[__1__](__${name}__)'},
          ),
        );
      case MessageCallType.leave:
        return _systemMessage(
          context,
          '@name left the group call'.trParams(
            {'name': '&[__1__](__${name}__)'},
          ),
        );

      case MessageCallType.decline:
      case MessageCallType.timeout:
      case MessageCallType.unreachable:
      case MessageCallType.unknown:
      default:
        return (message.room?.isGroup ?? false) ? _missedCallGroup(context) : _missedCall(context);
    }
  }

  Widget _callStartGroup(BuildContext context) {
    return _BoxItemGroup(
      icon: SvgPicture.asset(
        message.callMessage?.isVideo == true
            ? Assets.vectors.messageVideoCallIcon.path
            : Assets.vectors.messageCallIcon.path,
        colorFilter: ColorFilter.mode(
          context.theme.appColors.iconPrimary,
          BlendMode.srcIn,
        ),
        width: 20,
      ),
      text: AppText.body3(
        message.callMessage?.isVideo == true ? 'Group video call started'.tr : 'Group voice call started'.tr,
        color: message.mine ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDarkest,
        context: context,
        textAlign: TextAlign.center,
      ),
      backgroundColor:
          message.mine ? context.theme.appColors.backgroundPrimary : context.theme.appColors.backgroundNeutralLight,
      button: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          final room = await GetIt.I<RoomDb>().getRoom(message.roomId!);
          if (room == null) {
            return;
          }
          if (context.mounted) {
            final param = StartCallParam(
              callData: RoomCallModel.generateJoinGroupCall(
                room,
                message.callMessage?.isVideo == true ? CallType.video : CallType.voice,
              ),
            );
            if (message.callMessage?.isVideo == true) {
              GetIt.I<TaxonomyService>()
                  .sendEvent(EventName.clickVideoCall, eventProperties: EventProperty.clickVideoCall('chat room'));
            } else {
              GetIt.I<TaxonomyService>()
                  .sendEvent(EventName.clickVoiceCall, eventProperties: EventProperty.clickVoiceCall('chat room'));
            }
            await GetIt.I<StartCallUseCase>().call(param);
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: AppSpace.space2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.roundedLg),
            color: context.theme.appColors.backgroundNeutralLightest,
          ),
          child: AppText.caption1Bold(
            'Join'.tr,
            context: context,
            color: message.mine ? context.theme.appColors.textPrimary : context.theme.appColors.textDarkest,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _callEnd(BuildContext context) {
    return _BoxItem(
      icon: SvgPicture.asset(
        message.callMessage?.isVideo == true
            ? Assets.vectors.messageVideoCallIcon.path
            : Assets.vectors.messageCallIcon.path,
        colorFilter: ColorFilter.mode(
          context.theme.appColors.iconPrimary,
          BlendMode.srcIn,
        ),
        width: 20,
      ),
      text: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.body3(
            message.callMessage?.isVideo == true ? 'Video call'.tr : 'Voice call'.tr,
            color: message.mine ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDarkest,
            context: context,
          ),
          AppText.body4(
            message.callMessage?.payload?.durationString ?? '',
            color: message.mine ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDarkest,
            context: context,
          ),
        ],
      ),
      backgroundColor:
          message.mine ? context.theme.appColors.backgroundPrimary : context.theme.appColors.backgroundNeutralLight,
    );
  }

  Widget _missedCall(BuildContext context) {
    return _BoxItem(
      icon: SvgPicture.asset(
        message.callMessage?.isVideo == true
            ? Assets.vectors.messageVideoMissCallIcon.path
            : Assets.vectors.messageCallIcon.path,
        colorFilter: ColorFilter.mode(
          context.theme.appColors.iconError,
          BlendMode.srcIn,
        ),
        width: 20,
      ),
      text: AppText.body3(
        'Missed'.tr,
        color: context.theme.appColors.textDarkest,
        context: context,
      ),
      backgroundColor: context.theme.appColors.backgroundNeutralLight,
    );
  }

  Widget _missedCallGroup(BuildContext context) {
    return _BoxItemGroup(
      icon: SvgPicture.asset(
        message.callMessage?.isVideo == true
            ? Assets.vectors.messageVideoMissCallIcon.path
            : Assets.vectors.messageCallIcon.path,
        colorFilter: ColorFilter.mode(
          context.theme.appColors.iconError,
          BlendMode.srcIn,
        ),
        width: 20,
      ),
      text: AppText.body3(
        'Missed'.tr,
        color: context.theme.appColors.textDarkest,
        context: context,
      ),
      backgroundColor: context.theme.appColors.backgroundNeutralLight,
      button: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          final room = await GetIt.I<RoomDb>().getRoom(message.roomId!);
          if (room == null) {
            return;
          }
          if (context.mounted) {
            final param = StartCallParam(callData: RoomCallModel.generateDirectCall(room, CallType.voice));
            GetIt.I<TaxonomyService>()
                .sendEvent(EventName.clickVoiceCall, eventProperties: EventProperty.clickVoiceCall('chat room'));

            await GetIt.I<StartCallUseCase>().call(param);
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: AppSpace.space2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.roundedLg),
            color: context.theme.appColors.backgroundNeutralLightest,
          ),
          child: AppText.caption1Bold(
            'Call back'.tr,
            context: context,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _systemMessage(BuildContext context, String text) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 0.7.sw),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.roundedFull),
          color: context.theme.appColors.backgroundGrayLightest,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.space2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSpace.space05.verticalSpace,
              Builder(builder: (context) {
                final style = context.theme.appTexts.caption2.copyWith(
                  color: context.theme.appColors.textDark,
                  fontSize: 11.spMin,
                );
                return ParsedText(
                  text: text,
                  style: style,
                  alignment: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  parse: <MatchText>[
                    _buildSystemMessageDisplayNameMatchText(context, style),
                  ],
                );
              }),
              AppSpace.space05.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  MatchText _buildSystemMessageDisplayNameMatchText(BuildContext context, TextStyle style) {
    final TextStyle matchStyle = style.copyWith(fontWeight: FontWeight.bold);
    return MatchText(
      onTap: (_) {},
      pattern: UChatConstant.systemMessageDisplayNameRegexPattern,
      style: matchStyle.copyWith(
        color: context.theme.appColors.textDark,
      ),
      renderText: ({
        required String pattern,
        required String str,
      }) {
        return str.markupToDisplayRegExHelper(pattern: UChatConstant.systemMessageDisplayNameRegexPattern);
      },
    );
  }
}

class _BoxItem extends StatelessWidget {
  const _BoxItem({
    required this.icon,
    required this.text,
    required this.backgroundColor,
  });

  final Widget icon;
  final Widget text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.5.sw,
      padding: const EdgeInsets.all(
        AppSpace.space3,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSpace.space10,
            height: AppSpace.space10,
            decoration: BoxDecoration(
              color: context.theme.appColors.backgroundNeutralLightest,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: icon,
            ),
          ),
          const SizedBox(
            width: AppSpace.space3,
          ),
          text,
        ],
      ),
    );
  }
}

class _BoxItemGroup extends StatelessWidget {
  const _BoxItemGroup({
    required this.icon,
    required this.text,
    required this.button,
    required this.backgroundColor,
  });

  final Widget icon;
  final Widget text;
  final Widget button;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.5.sw,
      padding: const EdgeInsets.all(
        AppSpace.space3,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
        color: backgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSpace.space10,
            height: AppSpace.space10,
            decoration: BoxDecoration(
              color: context.theme.appColors.backgroundNeutralLightest,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: icon,
            ),
          ),
          const SizedBox(
            height: AppSpace.space3,
          ),
          text,
          const SizedBox(
            height: AppSpace.space3,
          ),
          button,
        ],
      ),
    );
  }
}
