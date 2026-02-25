import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/presentation/controllers/app_share_bottom_sheet_controller.dart';
import 'package:uchat/core/presentation/widgets/app_primary_button.dart';
import 'package:uchat/core/presentation/widgets/app_search_box.dart';
import 'package:uchat/core/presentation/widgets/share_check_box_tile.dart';
import 'package:uchat/core/presentation/widgets/share_selected_preview.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_outlined_button.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class AppShareBottomSheet extends GetView<AppShareBottomSheetController> {
  final String? controllerTag;

  @override
  String? get tag => controllerTag;

  const AppShareBottomSheet({super.key, this.controllerTag});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(maxHeight: Get.height * 0.8), // Height of bottom sheet.
        margin: const EdgeInsets.only(
          left: AppSpace.space4,
          right: AppSpace.space4,
          bottom: AppSpace.space4,
        ), // Empty space around bottom sheet.
        decoration: BoxDecoration(
          // Bottom sheet background and border radius.
          color: context.theme.appColors.backgroundNeutralLightest,

          /// If you want to edit this border radius, Don't forget to edit border radius of Bottom area background to
          /// have the same value. because bottom area background have background color that will covered bottom sheet
          /// bottom border radius.
          borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              const SizedBox(height: AppSpace.space4),

              /// Bottom sheet handle for dragging.
              Container(
                decoration: BoxDecoration(
                  color: context.theme.appColors.iconDisable,
                  borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                ),
                width: AppSize.size12,
                height: AppSize.size1,
              ),
              const SizedBox(
                height: AppSpace.space3,
              ),
              AppText.title2(
                'Share with'.tr,
                context: context,
                color: context.theme.appColors.textDarkest,
              ),

              /// Selected room preview.
              _buildSelectedTargetPreview(context),

              /// Text field for caption.
              _buildCaptionTextField(context),

              /// Search text field.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
                child: AppSearchBox(
                  onChanged: controller.onSearchTextFieldChanged,
                  focusNode: controller.searchTextFieldFocusNode,
                  controller: controller.searchTextFieldController,
                ),
              ),
              const SizedBox(height: AppSpace.space3),

              /// All selectable room list.
              Expanded(
                child: ShareBottomSheetScrollView(controllerTag: controllerTag),
              ),

              /// Bottom area background and button.
              Container(
                decoration: BoxDecoration(
                  color: context.theme.appColors.backgroundNeutralLightest,

                  /// This need bottom border radius because otherwise this widget background is render on top of
                  /// bottom sheet. If this doesn't have border radius, The bottom part of bottom sheet will be covered
                  /// by the sharp edge of this container.
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(AppRadius.rounded3xl),
                    bottomRight: Radius.circular(AppRadius.rounded3xl),
                  ),
                ),
                padding: const EdgeInsets.only(
                  top: AppSpace.space3,
                  bottom: AppSpace.space4,
                  left: AppSpace.space4,
                  right: AppSpace.space4,
                ),
                child: _buildBottomButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedTargetPreview(BuildContext context) {
    return Obx(() {
      final widgetList = List.generate(controller.selectedTargetList.length, (e) {
        final item = controller.selectedTargetList()[e];

        return Padding(
          padding: EdgeInsets.only(
            right: e < controller.selectedTargetList.length - 1 ? AppSpace.space4 : 0,
            top: AppSpace.space2,
          ),
          child: ShareSelectedPreview(
            target: item,
            onClosePressed: () {
              controller.removeSelectedTarget(target: item);
            },
          ),
        );
      });

      // TODO ListView is not used here because ListView height have to be specified. If specific height can be use here change this to ListView.
      /// Use SingleChildScrollView and row here for now. This will render all selected
      /// target and not render only what shown in ui but unless user select tons of
      /// room to share this shouldn't cause performance issue. maybe.
      return Padding(
        padding: const EdgeInsets.only(
          left: AppSpace.space4,
          right: AppSpace.space4,
          top: AppSpace.space3,
        ),
        child: SizedBox(
          /// This is to force this row to use all space available for MainAxisAlignment.start to work.
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: controller.selectedTargetScrollController,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: widgetList,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCaptionTextField(BuildContext context) {
    return Obx(() {
      if (controller.hasSelected) {
        return Padding(
          padding: const EdgeInsets.only(
            left: AppSpace.space4,
            right: AppSpace.space4,
          ),
          child: TextField(
            inputFormatters: [ThaiLengthLimitingTextInputFormatter(UChatConstant.maxMessageInputLength)],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Write message...'.tr,
              hintStyle: context.theme.appTexts.body2.copyWith(
                color: context.theme.appColors.textLight,
              ),
            ),
            controller: controller.captionTextFieldController,
            focusNode: controller.captionTextFieldFocusNode,
            onTapOutside: (_) {
              controller.captionTextFieldFocusNode.unfocus();
            },
            style: context.theme.appTexts.body2,
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget _buildBottomButton(BuildContext context) {
    return Obx(() {
      if (controller.hasSelected || !controller.enableShareToOtherAppButton()) {
        /// Show share button after target is selected or share data can't be share to other app.

        return AppPrimaryButton.roundedL(
          onPressed: controller.hasSelected
              ? () {
                  controller.onSharePressed(context);
                }
              : null,
          buttonText: 'Share (@count)'.trParams({
            'count': controller.selectedTargetList().length.toString(),
          }),
          buttonColor: controller.hasSelected ? null : context.theme.appColors.buttonDisable,
          textColor: controller.hasSelected ? null : context.theme.appColors.textDisable,
        );
      } else {
        /// Show share in other app if target is not selected.
        return AppOutlinedButton.primary(
          onTap: () {
            controller.onShareInOtherAppPressed(context);
          },
          label: 'Share in other app'.tr,
          icon: Assets.vectors.iconApplication.svg(
            colorFilter: ColorFilter.mode(
              context.theme.appColors.iconPrimary,
              BlendMode.srcIn,
            ),
          ),
          context: context,
        );
      }
    });
  }
}

/// A Widget to show sharable room list in share bottom sheet.
/// Refactored this into a class because using class widget is (probably) better than using function that return widget
/// because Flutter has optimized widget class build process which doesn't work when using function that return widget.
/// Not sure how much does this effect performance.
/// TLDR : For complex or often rebuilt widget, Make it a widget is better.
class ShareBottomSheetScrollView extends GetView<AppShareBottomSheetController> {
  final String? controllerTag;

  @override
  String? get tag => controllerTag;

  const ShareBottomSheetScrollView({super.key, this.controllerTag});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.searchTextFieldController.text.isNotEmpty && controller.contactDisplayList.isEmpty
          ? _buildResultsNotFound(context)
          : CustomScrollView(
              slivers: [
                if (controller.recentChatDisplayList().isNotEmpty) ...[
                  /// Recent chat list title.
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
                      child: AppText.body3Bold(
                        'Recent chats'.tr,
                        context: context,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppSpace.space2),
                  ),

                  /// Recent chat list.
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Obx(() {
                          final item = controller.recentChatDisplayList()[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: AppSpace.space4),
                            child: ShareCheckBoxTile(
                              target: item,
                              isSelected: controller.selectedTargetList().any((e) => e.isSameTarget(item)),
                              onTap: () {
                                controller.onItemPressed(target: item);
                              },
                              onChanged: (_) {
                                controller.onItemPressed(target: item);
                              },
                            ),
                          );
                        });
                      },
                      childCount: min(5, controller.recentChatDisplayList().length),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppSpace.space6),
                  ),
                ],

                /// Contact list title.
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
                    child: RichText(
                      text: TextSpan(
                        text: 'Contacts'.tr,
                        style: context.theme.appTexts.body3Bold.copyWith(
                          color: context.theme.appColors.textDarkest,
                        ),
                        children: [
                          TextSpan(
                            text: ' ${controller.contactDisplayList().length}',
                            style: context.theme.appTexts.body3Bold.copyWith(
                              color: context.theme.appColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpace.space2),
                ),

                /// Contact list.
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Obx(() {
                        final item = controller.contactDisplayList()[index];

                        return Padding(
                          padding: const EdgeInsets.only(left: AppSpace.space4),
                          child: ShareCheckBoxTile(
                            target: item,
                            isSelected: controller.selectedTargetList().any((e) => e.isSameTarget(item)),
                            onTap: () {
                              controller.onItemPressed(target: item);
                            },
                            onChanged: (_) {
                              controller.onItemPressed(target: item);
                            },
                          ),
                        );
                      });
                    },
                    childCount: controller.contactDisplayList().length,
                  ),
                ),
              ],
            );
    });
  }

  Widget _buildResultsNotFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText.body2Bold(
            'No results found'.tr,
            context: context,
            color: context.theme.appColors.textDark,
          ),
          const SizedBox(height: AppSpace.space2),
          AppText.body4(
            'Please try searching again with different \nkeywords or check your spelling'.tr,
            context: context,
            color: context.theme.appColors.textLight,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: kToolbarHeight * 1.5),
        ],
      ),
    );
  }
}
