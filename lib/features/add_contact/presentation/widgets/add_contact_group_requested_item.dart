import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/group_request_type.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/avatar/avatar_wrapper.dart';

import '../../domain/entities/add_contact_group_requested_entity.dart';

class AddContactGroupRequestItem extends StatelessWidget {
  final AddContactGroupRequestedEntity? item;
  final void Function()? onTapItem;
  final void Function()? onApprove;

  const AddContactGroupRequestItem({
    super.key,
    this.item,
    this.onTapItem,
    this.onApprove,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapItem,
      child: SizedBox(
        width: double.maxFinite,
        child: Row(
          children: [
            /// Avatar section
            _buildAvatar(),
            AppSpace.space4.horizontalSpace,

            Expanded(
              child: Container(
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
                          /// Top space
                          AppSpace.space2.verticalSpace,

                          /// Title section
                          AppText.subtitle1(
                            item?.displayName ?? 'UNKNOWN'.tr,
                            maxLines: 1,
                            context: context,
                          ),
                          AppSpace.space1.verticalSpace,

                          /// subTitle section
                          RichText(
                            text: TextSpan(
                              text: 'Request to join the @name group'.trParams({
                                'name': item?.roomName ?? 'UNKNOWN'.tr,
                              }),
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

                          /// Bottom space
                          AppSpace.space2.verticalSpace,
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
    final avatarId = item?.avatarId ?? '';
    final accountId = item?.accountId ?? '';

    if (avatarId.isNotEmpty) {
      return AvatarWrapper(
        key: ValueKey(avatarId),
        data: item,
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
    final isAccepted = item?.type == GroupRequestType.cancelRequest;

    return Container(
      constraints: BoxConstraints(
        maxWidth: 90.spMin,
      ),
      margin: const EdgeInsets.only(left: AppSize.size3, right: AppSize.size4),
      child: TextButton(
        onPressed: onApprove,
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
    switch (item?.type) {
      case GroupRequestType.newRequest:
        return 'Approve'.tr;
      case GroupRequestType.cancelRequest:
        return 'Approve'.tr;
      default:
        return '';
    }
  }

  String _buildInviteDate() {
    final now = DateUtils.dateOnly(DateTime.now());
    final invitedTime = (item?.requestedAt ?? DateTime.now()).toLocal();
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
