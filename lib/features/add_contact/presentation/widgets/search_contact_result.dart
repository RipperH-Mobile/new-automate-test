import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/features/add_contact/presentation/controller/add_contact_search_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/styles.dart';
import 'package:uchat/utils/uchat_image.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

class SearchContactResult extends GetView<AddContactSearchController> {
  const SearchContactResult({super.key});

  double get sizeWidget => 266.spMin;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final searchResult = controller.searchResult.value!;

      return Column(
        children: [
          Container(
            width: sizeWidget,
            decoration: ShapeDecoration(
              color: context.theme.appColors.backgroundNeutralLightest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.spMin),
                side: const BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Colors.transparent,
                ),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x1918263B),
                  blurRadius: 16,
                  offset: Offset(0, 6),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Stack(
              children: [
                _buildBackgroundImage(
                  UChatImage.network(
                    searchResult.avatarUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                _buildBackgroundImage(
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                    child: Container(
                      color: Colors.white.withValues(alpha: 0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: AppSpace.space14),
                  child: Column(
                    children: [
                      AvatarWrapper<ContactInterface>(
                        radius: 60.spMin,
                        borderColor: colorPalette3,
                        data: searchResult,
                        showOnlineStatus: false,
                      ),
                      AppSpace.space4.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.only(left: AppSpace.space2, right: AppSpace.space2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (searchResult.isOfficial)
                              Assets.vectors.oaIcon.svg(
                                height: AppSize.size4.spMin,
                                width: AppSize.size4.spMin,
                              ),
                            AppSpace.space1.horizontalSpace,
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: AppSpace.space1, right: AppSpace.space1),
                                child: Text(
                                  searchResult.name ?? searchResult.username ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.theme.appTexts.button1Bold.copyWith(
                                    color: context.theme.appColors.textDarkest,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSpace.space6.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpace.space4),
                        child: SizedBox(
                          width: sizeWidget,
                          child: buildActionButton(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppSpace.space8.verticalSpace,
          Obx(() {
            String text = controller.isMe.value
                ? 'You can\'t add yourself as a friend.'
                : searchResult.isFriend
                    ? 'This user is already your friend.'
                    : '';

            return AppText.body3(
              text.tr,
              color: context.theme.appColors.textLight,
              context: context,
            );
          }),
        ],
      );
    });
  }

  Widget _buildBackgroundImage(Widget child) {
    return Container(
      height: 123.spMin,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: AppSize.size1, color: Colors.white),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRadius.rounded3xl),
            topRight: Radius.circular(AppRadius.rounded3xl),
          ),
        ),
      ),
      child: SizedBox(
        width: sizeWidget,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.spMin),
            topRight: Radius.circular(20.spMin),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget buildActionButton(BuildContext context) {
    return Obx(() {
      final searchResult = controller.searchResult.value!;
      final isRequested = controller.addContactCrl.friendRequestList.where((e) => e.id == searchResult.id).firstOrNull;

      return Container(
        height: AppSize.size10.spMin,
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
        color: context.theme.appColors.backgroundNeutralLightest,
        child: searchResult.isMe
            ? const SizedBox.shrink()
            : Row(
                spacing: AppSpace.space2,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  searchResult.isFriend
                      ? Expanded(
                          child: _buildButton(
                            context,
                            title: 'Chat'.tr,
                            onPressed: controller.handleOpenChat,
                            textColor: context.theme.appColors.textPrimary,
                          ),
                        )
                      : isRequested == null
                          ? Expanded(
                              child: _buildButton(
                                context,
                                title: 'Add friend'.tr,
                                onPressed: controller.handleAddFriend,
                                backgroundColor: context.theme.appColors.backgroundPrimary,
                                textColor: context.theme.appColors.textPrimaryInverse,
                                hasBorder: false,
                              ),
                            )
                          : const SizedBox.shrink(),
                  if (!searchResult.isFriend && isRequested != null) ...[
                    Expanded(
                      child: _buildButton(
                        context,
                        title: 'Accept'.tr,
                        onPressed: () => controller.handleAcceptFriend(searchResult.id ?? ''),
                        backgroundColor: context.theme.appColors.backgroundPrimary,
                        textColor: context.theme.appColors.textPrimaryInverse,
                        hasBorder: false,
                      ),
                    ),
                    Expanded(
                      child: _buildButton(
                        context,
                        title: 'Decline'.tr,
                        onPressed: controller.handleDeclineFriendRequest,
                      ),
                    ),
                  ],
                ],
              ),
      );
    });
  }

  Widget _buildButton(
    BuildContext context, {
    required String title,
    Color? textColor,
    Color? borderColor,
    Color? backgroundColor,
    void Function()? onPressed,
    bool hasBorder = true,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(Size.fromHeight(52.spMin)),
        backgroundColor: WidgetStateProperty.all(backgroundColor ?? context.theme.appColors.buttonSecondary),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: hasBorder
                ? BorderSide(color: borderColor ?? context.theme.appColors.border, width: 1)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(AppRadius.roundedXl),
          ),
        ),
      ),
      child: Text(
        title,
        style: context.theme.appTexts.button2Bold.copyWith(
          color: textColor ?? context.theme.appColors.textDarkest,
          height: 1,
        ),
      ),
    );
  }
}
