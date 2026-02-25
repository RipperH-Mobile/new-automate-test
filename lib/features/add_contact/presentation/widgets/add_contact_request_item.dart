import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/central_noti_type.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/avatar/avatar_wrapper.dart';

import '../../domain/entities/add_contact_invited_entity.dart';

class AddContactRequestItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String avatarId;
  final String accountId;
  final DateTime invitedAt;
  final CentralNotiType? type;
  final AddContactInvitedEntity? data;
  final void Function()? onTap;
  final void Function()? onAccept;
  final bool isFriendRequest;

  const AddContactRequestItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.avatarId,
    required this.accountId,
    required this.invitedAt,
    this.type,
    this.data,
    this.onTap,
    this.onAccept,
    this.isFriendRequest = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.maxFinite,
        child: Row(
          children: [
            /// Avatar section
            Stack(
              children: [
                _buildAvatar(),
                Positioned(
                  right: -7.spMin,
                  bottom: -6.spMin,
                  child: isFriendRequest
                      ? Assets.vectors.friendIndicator.svg(height: AppSize.size10.spMin, width: AppSize.size10.spMin)
                      : Assets.vectors.groupIndicator.svg(height: AppSize.size10.spMin, width: AppSize.size10.spMin),
                ),
              ],
            ),
            AppSpace.space4.horizontalSpace,

            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSize.size2),
                constraints: const BoxConstraints(
                  minHeight: AppSize.size20,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: context.theme.appColors.border,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// Title section
                          AppText.subtitle1(title, context: context),
                          AppSpace.space1.verticalSpace,

                          /// subTitle section
                          RichText(
                            text: TextSpan(
                              text: subTitle,
                              style: context.theme.appTexts.body4.copyWith(
                                color: context.theme.appColors.textDarkest,
                              ),
                              children: [
                                TextSpan(
                                  text: _buildInviteDate(),
                                  style: context.theme.appTexts.body4.copyWith(
                                    color: context.theme.appColors.textLighter,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Accept button
                    _buildButton(context),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (avatarId.isNotEmpty) {
      return AvatarWrapper(
        key: ValueKey(avatarId),
        data: data,
        imageAvatarId: avatarId,
        borderColor: Colors.transparent,
        showOnlineStatus: false,
        radius: 31.spMin,
      );
    }

    return AvatarWrapper(
      key: ValueKey(accountId),
      imageUrl: AccountService().getUserPublicAvatar(accountId),
      borderColor: Colors.transparent,
      radius: 31.spMin,
      imageAvatarId: '',
    );
  }

  Widget _buildButton(BuildContext context) {
    final isAccepted = [
      CentralNotiType.declineGroup,
      CentralNotiType.declineFriend,
      CentralNotiType.acceptGroup,
      CentralNotiType.acceptFriend,
    ].contains(type);

    return Container(
      constraints: BoxConstraints(
        maxWidth: 90.spMin,
      ),
      margin: const EdgeInsets.only(left: AppSize.size3, right: AppSize.size4),
      child: TextButton(
        onPressed: onAccept,
        style: TextButton.styleFrom(
          backgroundColor: isAccepted ? context.theme.appColors.buttonDisable : context.theme.appColors.buttonPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.roundedXl),
          ),
        ),
        child: AppText.body4Bold(
          buttonTitle(),
          color: isAccepted ? context.theme.appColors.textDisable : context.theme.appColors.textPrimaryInverse,
          context: context,
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  String buttonTitle() {
    switch (type) {
      case CentralNotiType.declineGroup:
      case CentralNotiType.declineFriend:
        return 'Declined'.tr;
      case CentralNotiType.groupDeleted:
      case CentralNotiType.inviteGroup:
        return 'Join'.tr;
      case CentralNotiType.acceptGroup:
        return 'Joined'.tr;
      case CentralNotiType.friendDeleted:
      case CentralNotiType.newFriend:
        return 'Accept'.tr;
      case CentralNotiType.acceptFriend:
        return 'Accepted'.tr;
      default:
        return '';
    }
  }

  String _buildInviteDate() {
    final now = DateUtils.dateOnly(DateTime.now());
    final invitedTime = invitedAt.toLocal();
    final dateOnly = DateUtils.dateOnly(invitedTime);

    final timeDiff = now.difference(dateOnly).inDays;

    if (timeDiff < 0) return '';

    if (timeDiff == 0) {
      final notiTime = invitedTime.toString().substring(11, 16);

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

    final date = invitedTime.format('LLL d, y');

    return ', $date';
  }
}
