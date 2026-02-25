import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/profile/presentation/profile_presentation.dart';
import 'package:uchat/features/profile/presentation/views/widgets/corner_box_menu.dart';
import 'package:uchat/features/profile/presentation/views/widgets/my_profile_uchat_id_menu.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets/app_text.dart';

const _kAppBarMaxHeightRatio = 0.48;

class MyProfileScreen extends GetView<UserController> {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final maxHeight = (Get.height * _kAppBarMaxHeightRatio);
    final minHeight = kToolbarHeight + MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: context.theme.appColors.surfaceDark,
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (_) {
          _snapAppbar(context, controller.scrollController);
          return false;
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: controller.scrollController,
          slivers: [
            _buildSliverAppbar(context, maxHeight, minHeight),
            SliverFillRemaining(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpace.space4,
                ),
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: AppSpace.space6,
                    ),
                    CornerBoxMenu(
                      children: [
                        Obx(
                          () {
                            final hasPhoneNumber = controller.currentUser.value?.phoneNumber != null &&
                                controller.currentUser.value!.phoneNumber!.isNotEmpty &&
                                !controller.currentPhoneNumber.value.contains('Phone number not found'.tr);

                            return CornerBoxMenuItemListTitle(
                              title: AppText.body3(
                                'Phone number'.tr,
                                context: context,
                              ),
                              subtitle: AppText.body1(
                                controller.currentPhoneNumber.value,
                                context: context,
                                color: hasPhoneNumber
                                    ? context.theme.appColors.textPrimary
                                    : context.theme.appColors.textLight,
                              ),
                              onTap: hasPhoneNumber ? () => controller.copyPhoneNumberToClipboard(context) : null,
                            );
                          },
                        ),
                        Obx(
                          () => MyProfileUchatIdMenu(
                            uchatId: controller.currentUser()?.username,
                          ),
                        ),
                        Obx(
                          () => CornerBoxMenuItemListTitle(
                            title: AppText.body3(
                              'Date of birth'.tr,
                              context: context,
                            ),
                            subtitle: AppText.body1(
                              controller.formattedBirthDate,
                              context: context,
                              color: controller.currentUser()?.birthDate != null &&
                                      controller.currentUser()!.birthDate!.isNotEmpty
                                  ? context.theme.appColors.textDarkest
                                  : context.theme.appColors.textLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.size4,
                    ),
                    CornerBoxMenu(
                      children: [
                        Obx(
                          () => CornerBoxMenuItemListTitle.toggle(
                            title: AppText.body1(
                              'Show online status'.tr,
                              context: context,
                            ),
                            value: controller.friendCanSeeMyLastSeen.value,
                            onChanged: controller.handleToggleFriendCanSeeMyLastSeen,
                            context: context,
                          ),
                        ),
                        Obx(
                          () => CornerBoxMenuItemListTitle.toggle(
                            title: AppText.body1(
                              'Hide phone number'.tr,
                              context: context,
                            ),
                            value: controller.isHidePhoneNumber.value,
                            onChanged: controller.handleToggleHidePhoneNumber,
                            context: context,
                          ),
                        ),
                        CornerBoxMenuItemListTitle.arrow(
                          title: AppText.body1(
                            'PIN lock'.tr,
                            context: context,
                          ),
                          onTap: () => controller.handlePasscodeLock(null),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppbar(
    BuildContext context,
    double maxHeight,
    double minHeight,
  ) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      stretch: false,
      floating: false,
      expandedHeight: maxHeight - MediaQuery.of(context).padding.top,
      flexibleSpace: Obx(
        () => ProfileHeader(
          maxHeight: maxHeight,
          minHeight: minHeight,
          avatarUrl: controller.currentUser.value?.avatarUrl ?? '',
          name: controller.currentUser.value?.displayName ?? '',
          status: controller.currentUser.value?.statusMessage ?? '',
          onEdit: () => Get.toNamed(Routes.settingMyProfile),
        ),
      ),
    );
  }

  void _snapAppbar(BuildContext context, ScrollController controller) {
    final maxHeight = (Get.height * _kAppBarMaxHeightRatio);
    final minHeight = kToolbarHeight + MediaQuery.of(context).padding.top;
    final scrollDistance = maxHeight - minHeight;

    if (controller.offset > 0 && controller.offset < scrollDistance) {
      final double snapOffset = controller.offset / scrollDistance > 0.5 ? scrollDistance : 0;
      if (controller.hasClients) {
        Future.microtask(
          () => controller.animateTo(
            snapOffset,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          ),
        );
      }
    }
  }
}
