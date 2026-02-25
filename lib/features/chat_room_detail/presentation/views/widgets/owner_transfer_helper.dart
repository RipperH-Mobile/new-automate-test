import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/app_button_size.dart';
import 'package:uchat/entities/enum/app_button_style.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/detail_all_members_list_item.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';

/// Helper class for showing owner transfer bottom sheet
class OwnerTransferHelper {
  /// Show owner transfer bottom sheet
  ///
  /// Parameters:
  /// - [context]: BuildContext for theming
  /// - [nextOwnerSuggestionList]: Reactive list of suggested next owners
  /// - [allAdminAndMembersCount]: Reactive count of all admins and members
  /// - [onOwnerTransfer]: Callback when user selects a member to transfer to
  /// - [onSkipAndLeave]: Callback when user wants to skip and leave directly
  /// - [onNavigateToOwnerTransferScreen]: Optional callback to navigate to full owner transfer screen
  static void showOwnerTransferBottomSheet({
    required BuildContext context,
    required Rx<List<RoomMemberEntity>> nextOwnerSuggestionList,
    required RxInt allAdminAndMembersCount,
    required Function(RoomMemberEntity) onOwnerTransfer,
    required VoidCallback onSkipAndLeave,
    VoidCallback? onNavigateToOwnerTransferScreen,
  }) {
    Get.bottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      SafeArea(
        child: Container(
          padding: const EdgeInsets.all(AppSpace.space4),
          decoration: BoxDecoration(
            color: context.theme.appColors.backgroundNeutralLightest,
            borderRadius: const BorderRadius.all(
              Radius.circular(AppSpace.space8),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: AppSpace.space4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.title2(
                            'Transfer ownership to leave group'.tr,
                            context: context,
                            color: context.theme.appColors.textDarkest,
                            textAlign: TextAlign.start,
                          ),
                          AppText.body2(
                            'You are the owner of this group. If you want to leave this group, you need to transfer ownership to someone in the group first.'
                                .tr,
                            context: context,
                            color: context.theme.appColors.textDark,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Assets.vectors.iconCancelButtonBottomsheet.svg(),
                  ),
                ],
              ),
              const SizedBox(height: AppSpace.space4),
              Container(
                decoration: BoxDecoration(
                  color: context.theme.appColors.backgroundNeutralLight,
                  borderRadius: BorderRadius.circular(AppSpace.space6),
                ),
                child: Obx(() {
                  final memberCount = allAdminAndMembersCount.value;
                  final members = nextOwnerSuggestionList.value;
                  final displayCount = memberCount >= 6 ? 6 : memberCount;

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: displayCount,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final isLastIndex =
                          (memberCount >= 6 && index == 5) || (memberCount < 6 && index == memberCount - 1);

                      // Only show if member exists in list
                      if (index >= members.length) {
                        return const SizedBox.shrink();
                      }

                      return DetailAllMembersListItem(
                        moreAmountMembers: memberCount - 5,
                        onTapProfile: () {
                          if (isLastIndex && memberCount > 6) {
                            Get.back();
                            onNavigateToOwnerTransferScreen?.call();
                          } else {
                            onOwnerTransfer(members[index]);
                          }
                        },
                        isLastIndex: isLastIndex,
                        member: members[index],
                      );
                    },
                  );
                }),
              ),
              const SizedBox(height: AppSpace.space4),
              AppFilledButton.error(
                context: context,
                label: 'Skip & Leave group'.tr,
                style: AppButtonStyle.fullRounded,
                onTap: () {
                  Get.back();
                  onSkipAndLeave();
                },
                size: AppButtonSize.medium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
