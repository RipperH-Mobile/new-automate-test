import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/profile/presentation/views/widgets/corner_box_menu.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

import 'package:uchat/features/profile/presentation/controllers/group_profile_controller.dart';

class GroupMemberSection extends GetView<GroupProfileController> {
  const GroupMemberSection({super.key});

  static const double _avatarSize = 40;
  static const double _spacing = 4;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // ignore: invalid_use_of_protected_member
        final members = controller.members.value;

        // Show skeleton loading while fetching members
        // ignore: invalid_use_of_protected_member
        if (controller.loading.value && members.isEmpty) {
          return CornerBoxMenu.singleItem(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.body3(
                  'Member'.tr,
                  context: context,
                ),
                const SizedBox(height: AppSpace.space3),
                _buildSkeletonAvatars(context),
              ],
            ),
          );
        }

        return CornerBoxMenu.singleItem(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.body3(
                'Member'.tr,
                context: context,
              ),
              const SizedBox(height: AppSpace.space3),
              GestureDetector(
                onTap: controller.room.value?.isJoined == true
                    ? () {
                        controller.handleOpenRoomMemberView();
                      }
                    : null,
                child: _buildMemberAvatars(context, members),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMemberAvatars(BuildContext context, List<RoomMemberEntity> members) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate how many avatars can fit in the available width
        final availableWidth = constraints.maxWidth;
        final maxDisplay = ((availableWidth + _spacing) / (_avatarSize + _spacing)).floor();

        // Determine how many avatars to display
        final hasMore = members.length > maxDisplay;
        final displayCount = hasMore ? maxDisplay : members.length;

        return Wrap(
          spacing: _spacing,
          runSpacing: _spacing,
          children: List.generate(displayCount, (i) {
            final isLastItem = i == displayCount - 1;
            final shouldShowExtraCount = isLastItem && hasMore;

            final account = members[i].account;
            final accountId = account.id;
            final avatarId = account.avatarId;

            if (accountId == null || avatarId == null) {
              return AvatarWrapper(
                radius: _avatarSize / 2,
                borderWidth: 0,
              );
            }

            if (shouldShowExtraCount) {
              final extraCount = members.length - displayCount + 1;
              return _buildExtraCountAvatar(
                context: context,
                count: extraCount,
                avatarId: avatarId,
                accountId: accountId,
              );
            } else {
              return _buildMemberAvatar(
                context: context,
                avatarId: avatarId,
                accountId: accountId,
              );
            }
          }),
        );
      },
    );
  }

  Widget _buildMemberAvatar({
    required BuildContext context,
    required String avatarId,
    required String accountId,
  }) {
    return AvatarWrapper(
      radius: _avatarSize / 2,
      borderWidth: 0,
      imageAvatarId: avatarId,
      id: accountId,
    );
  }

  Widget _buildExtraCountAvatar({
    required BuildContext context,
    required int count,
    required String avatarId,
    required String accountId,
  }) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AvatarWrapper(
          radius: _avatarSize / 2,
          borderWidth: 0,
          imageAvatarId: avatarId,
          id: accountId,
        ),
        Container(
          width: _avatarSize,
          height: _avatarSize,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: AppText.body3Bold(
              '+$count',
              context: context,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkeletonAvatars(BuildContext context) {
    const int skeletonCount = 7; // Show 7 skeleton avatars

    return ShimmerLoading(
      enable: true,
      baseColor: context.theme.appColors.backgroundGrayLighter,
      highlightColor: context.theme.appColors.backgroundGrayLightest,
      child: Wrap(
        spacing: _spacing,
        runSpacing: _spacing,
        children: List.generate(skeletonCount, (i) {
          return Container(
            width: _avatarSize,
            height: _avatarSize,
            decoration: BoxDecoration(
              color: context.theme.appColors.backgroundGrayLighter,
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}
