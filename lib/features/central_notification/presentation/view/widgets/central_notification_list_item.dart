import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/central_noti_type.dart';
import 'package:uchat/features/contact/domain/params/get_contact_name_params.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_name_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_sync_use_case.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/utils/extension/extension_number.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/avatar/avatar_wrapper.dart';

import '../../../domain/entities/central_notification_entity.dart';

class CentralNotificationListItem extends StatelessWidget {
  final CentralNotificationEntity centralNoti;
  final CentralNotiType notiType;
  final bool isOffline;
  final void Function() onJoinGroupInvite;
  final void Function() onAcceptFriendReq;
  final void Function() onApproveGroupReq;

  CentralNotificationListItem({
    super.key,
    required this.centralNoti,
    required this.notiType,
    required this.isOffline,
    required this.onJoinGroupInvite,
    required this.onAcceptFriendReq,
    required this.onApproveGroupReq,
  });

  final accountService = AccountService();
  final fileService = FileService();

  double get avatarRadius => AppSize.size8;

  double get avatarPadding => AppSize.size4;

  double get avatarSpace => AppSize.size3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(minHeight: 80.spMin),
          child: Padding(
            padding: EdgeInsets.only(right: AppSize.size4.spMin),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: avatarPadding.spMin, right: 2.spMin, bottom: 2.spMin),
                      child: _buildAvatar(context),
                    ),
                    Positioned(
                      right: -6,
                      bottom: -4,
                      child: notiType == CentralNotiType.sendGiftSticker
                          ? Image.asset(
                              'assets/images/v2/noti_gift.png',
                              height: 35.spMin,
                              width: 35.spMin,
                              cacheWidth: 35.spMin.cacheSize,
                            )
                          : notiType == CentralNotiType.acceptFriend || notiType == CentralNotiType.friendAccept
                              ? Assets.vectors.friendIndicator.svg(
                                  height: AppSize.size10.spMin,
                                  width: AppSize.size10.spMin,
                                )
                              : Assets.vectors.groupIndicator.svg(
                                  height: AppSize.size10.spMin,
                                  width: AppSize.size10.spMin,
                                ),
                    ),
                  ],
                ),
                SizedBox(width: avatarSpace.spMin),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(child: _buildTitle(context)),
                      _buildButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: ((avatarRadius * 2) + avatarPadding + avatarSpace + 2).spMin),
          child: Divider(
            height: 0.3,
            color: context.theme.appColors.borderDark,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    String? roomPhotoId;
    final accountId = centralNoti.data?.accountId ?? '';

    switch (notiType) {
      case CentralNotiType.declineGroup:
      case CentralNotiType.groupDeleted:
      case CentralNotiType.inviteGroup:
      case CentralNotiType.acceptGroup:
        roomPhotoId = centralNoti.data?.roomPhotoId;
      case CentralNotiType.newFriend:
      case CentralNotiType.declineFriend:
      case CentralNotiType.friendDeleted:
      case CentralNotiType.acceptFriend:
      case CentralNotiType.groupAccept:
      case CentralNotiType.friendAccept:
      case CentralNotiType.sendGiftSticker:
      default:
    }

    if (roomPhotoId != null) {
      return AvatarWrapper(
        key: ValueKey(roomPhotoId),
        imageAvatarId: roomPhotoId,
        borderColor: Colors.transparent,
        radius: avatarRadius.spMin,
        roomType: 'GROUP',
      );
    }
    final contact = GetIt.I<GetContactSyncUseCase>().call(accountId);
    if (contact != null) {
      return AvatarWrapper(
        key: ValueKey(accountId),
        data: contact,
        borderColor: Colors.transparent,
        radius: avatarRadius.spMin,
        imageAvatarId: '',
      );
    }

    return AvatarWrapper(
      key: ValueKey(accountId),
      imageUrl: accountService.getUserPublicAvatar(accountId),
      borderColor: Colors.transparent,
      radius: avatarRadius.spMin,
      imageAvatarId: '',
    );
  }

  Widget _buildButtonBox({
    required String buttonTitle,
    void Function()? onPressed,
    bool isActive = false,
    required BuildContext context,
  }) {
    return Container(
      width: 84,
      margin: EdgeInsets.only(left: AppSize.size3.spMin),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: isActive ? context.theme.appColors.buttonPrimary : context.theme.appColors.buttonDisable,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.roundedXl),
          ),
        ),
        child: AppText.body4Bold(
          buttonTitle,
          color: isActive ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDisable,
          context: context,
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    if (isHasButton) {
      if (notiType == CentralNotiType.inviteGroup) {
        return _buildButtonBox(
          buttonTitle: 'Join'.tr,
          onPressed: onJoinGroupInvite,
          isActive: true,
          context: context,
        );
      } else if (notiType == CentralNotiType.declineGroup || notiType == CentralNotiType.declineFriend) {
        return _buildButtonBox(buttonTitle: 'Declined'.tr, context: context);
      } else if (notiType == CentralNotiType.acceptGroup) {
        return _buildButtonBox(buttonTitle: 'Joined'.tr, context: context);
      } else if (notiType == CentralNotiType.groupDeleted) {
        return _buildButtonBox(buttonTitle: 'Join'.tr, context: context);
      } else if (notiType == CentralNotiType.friendDeleted) {
        return _buildButtonBox(buttonTitle: 'Accept'.tr, context: context);
      } else if (notiType == CentralNotiType.newFriend) {
        return _buildButtonBox(
          buttonTitle: 'Accept'.tr,
          onPressed: onAcceptFriendReq,
          isActive: true,
          context: context,
        );
      } else if (notiType == CentralNotiType.acceptFriend) {
        return _buildButtonBox(buttonTitle: 'Accepted'.tr, context: context);
      } else if (notiType == CentralNotiType.requestGroup) {
        return _buildButtonBox(
          buttonTitle: 'Approve'.tr,
          onPressed: onApproveGroupReq,
          isActive: true,
          context: context,
        );
      } else if (notiType == CentralNotiType.requestGroupApproved) {
        return _buildButtonBox(buttonTitle: 'Approved'.tr, context: context);
      } else if (notiType == CentralNotiType.requestGroupDeclined) {
        return _buildButtonBox(buttonTitle: 'Rejected'.tr, context: context);
      } else if (notiType == CentralNotiType.requestGroupJoined) {
        return _buildButtonBox(buttonTitle: 'Joined'.tr, context: context);
      }
    }

    return const SizedBox.shrink();
  }

  bool get isHasButton {
    if (notiType == CentralNotiType.groupAccept || notiType == CentralNotiType.friendAccept) {
      return false;
    }

    return true;
  }

  Widget _buildTitle(BuildContext context) {
    final contactName = getContactName();
    String contentTitle = contactName ?? centralNoti.data?.displayName ?? 'UNKNOWN'.tr;
    String contentText = '';

    switch (notiType) {
      case CentralNotiType.declineGroup:
      case CentralNotiType.groupDeleted:
      case CentralNotiType.inviteGroup:
      case CentralNotiType.acceptGroup:
        contentTitle = centralNoti.data?.roomName ?? 'UNKNOWN'.tr;
        final name = contactName ?? centralNoti.data?.displayName ?? 'Someone'.tr;
        contentText = '@name has sent you an invitation to join group'.trParams({'name': name});
        break;
      case CentralNotiType.newFriend:
      case CentralNotiType.declineFriend:
      case CentralNotiType.friendDeleted:
        contentTitle = contactName ?? centralNoti.data?.displayName ?? 'UNKNOWN'.tr;
        contentText = 'Sent you a friend request'.tr;
        break;
      case CentralNotiType.acceptFriend:
        contentText = 'Sent you a friend request'.tr;
        break;
      case CentralNotiType.groupAccept:
        contentTitle = contactName ?? centralNoti.data?.displayName ?? 'UNKNOWN'.tr;
        final name = centralNoti.data?.roomName ?? 'UNKNOWN'.tr;
        contentText = 'Accepted the invitation to join the **@name** group from your invitation'.trParams({
          'name': name,
        });
        break;
      case CentralNotiType.friendAccept:
        contentText = 'Accepted your friend request'.tr;
        break;
      case CentralNotiType.sendGiftSticker:
        final name = centralNoti.data?.stickerName ?? 'UNKNOWN'.tr;
        contentText = 'Send sticker **@name** as a gift to you'.trParams({'name': name});
      case CentralNotiType.requestGroup:
      case CentralNotiType.requestGroupApproved:
      case CentralNotiType.requestGroupDeclined:
      case CentralNotiType.requestGroupJoined:
        contentTitle = contactName ?? centralNoti.data?.displayName ?? 'UNKNOWN'.tr;
        final name = centralNoti.data?.roomName ?? 'UNKNOWN'.tr;
        contentText = 'Request to join the @name group'.trParams({'name': name});
      case CentralNotiType.groupDeclined:
        contentTitle = contactName ?? centralNoti.data?.displayName ?? 'Someone'.tr;
        final name = centralNoti.data?.roomName ?? 'UNKNOWN'.tr;
        contentText = 'Declined the invitation to join the **@name** from your invitation'.trParams({'name': name});
        break;
      default:
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppSpace.space2.spMin.verticalSpace,
        AppText.subtitle1(
          contentTitle,
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
          context: context,
        ),
        AppSpace.space1.spMin.verticalSpace,
        GptMarkdownTheme(
          gptThemeData: GptMarkdownThemeData(brightness: Brightness.light),
          child: GptMarkdown(
            '$contentText`${_buildDateTime()}`',
            style: context.theme.appTexts.body3.copyWith(
              color: context.theme.appColors.textDarkest,
              overflow: TextOverflow.ellipsis,
            ),
            highlightBuilder: (context, text, style) {
              return AppText.body3(
                text,
                color: context.theme.appColors.textLighter,
                context: context,
              );
            },
          ),
        ),
        AppSpace.space2.spMin.verticalSpace,
      ],
    );
  }

  String? getContactName() {
    final roomId = centralNoti.data?.roomId;
    final accountId = centralNoti.data?.accountId;
    if (accountId == null) return null;

    if (roomId != null) {
      return GetIt.I<GetContactNameUseCase>().call(
        ContactNameParams(
          roomId: roomId,
          accountId: accountId,
        ),
      );
    } else {
      final contact = GetIt.I<GetContactSyncUseCase>().call(accountId);
      return contact?.shortName;
    }
  }

  String _buildDateTime() {
    if (centralNoti.createdAt == null) return '';

    final now = DateTime.now().toLocal();
    final nowDayOnly = DateUtils.dateOnly(now);
    final notiDateTime = centralNoti.createdAt == null ? now : centralNoti.createdAt!.toLocal();
    final notiDateOnly = DateUtils.dateOnly(notiDateTime);
    final timeDiff = nowDayOnly.difference(notiDateOnly).inDays;

    if (timeDiff < 0) return '';

    if (timeDiff == 0) {
      final isLessThanOneMinute = now.difference(notiDateTime).inMinutes < 1;
      if (isLessThanOneMinute) return ', Now'.tr;

      final notiTime = notiDateTime.toString().substring(11, 16);

      return ', @time'.trParams({'time': notiTime});
    } else if (timeDiff == 1) {
      return ', yesterday'.tr;
    } else if (timeDiff > 1 && timeDiff < 7) {
      return ', @days days ago'.trParams({'days': '$timeDiff'});
    } else if (timeDiff >= 7 && timeDiff < 14) {
      return ', 1 week ago'.tr;
    } else if (timeDiff >= 14 && timeDiff < 21) {
      return ', 2 weeks ago'.tr;
    } else if (timeDiff >= 21 && timeDiff <= 30) {
      return ', 3 weeks ago'.tr;
    }

    final date = (centralNoti.createdAt ?? DateTime.now()).toLocal().format('LLL d, y');

    return ', $date';
  }
}
