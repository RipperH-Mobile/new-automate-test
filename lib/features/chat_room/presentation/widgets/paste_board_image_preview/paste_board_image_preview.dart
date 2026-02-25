import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/presentation/controllers/paste_board_image_preview_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/mention_text_field.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/extension/extension_number.dart';
import 'package:uchat/utils/vibrate.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/checkbox/round_checkbox.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class PasteBoardImagePreviewBottomSheet extends GetView<PasteBoardImagePreviewController> {
  final String tagString;

  const PasteBoardImagePreviewBottomSheet({
    super.key,
    required this.tagString,
  });

  @override
  String get tag => tagString;

  static const double imageHeight = 267;
  static const double imageWidth = 200.0;
  static const double textFieldHeight = 44.0;
  static const double textHeight = 24;
  static const double textBoxHeight = textHeight + AppSpace.space4;
  static const double imageBoxSize = (imageHeight + (AppSpace.space6 * 2));
  static const double dragToReorderHeight = 44;
  static const double textFieldBoxHeight = textFieldHeight + AppSpace.space4;
  static const double height = textBoxHeight + imageBoxSize + dragToReorderHeight + textFieldBoxHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.onBodyTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Title section
          Obx(() {
            return Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(bottom: AppSpace.space4),
              color: context.theme.appColors.backgroundNeutralLightest,
              alignment: Alignment.center,
              child: AppText.title3(
                '@count Selected'.trParams({
                  'count': controller.selectedCount.value.toString(),
                }),
                color: context.theme.appColors.textDarkest,
                context: context,
              ),
            );
          }),

          // Images preview section
          Container(
            height: imageHeight,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: AppSpace.space6),
            child: Obx(() => _buildImageList(context)),
          ),

          // Drag to reorder label section
          Obx(() {
            return (controller.allImages.length > 1)
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space2, vertical: AppSpace.space1),
                        decoration: BoxDecoration(
                          color: context.theme.appColors.backgroundGrayLightest,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: AppText.caption2(
                          'Drag to reorder'.tr,
                          color: context.theme.appColors.textDark,
                          context: context,
                        ),
                      ),
                      const SizedBox(height: AppSpace.space4),
                    ],
                  )
                : const SizedBox.shrink();
          }),

          // Text input section
          _buildMentionTextField(context),
        ],
      ),
    );
  }

  Widget _buildImageList(BuildContext context) {
    final allImages = controller.allImages();

    if (allImages.isEmpty) {
      return const SizedBox.shrink();
    }

    // Just one image
    if (allImages.length == 1) {
      if (allImages[0].isTooLarge) {
        return const SizedBox.shrink(key: ValueKey('image-preview-0'));
      } else if (allImages[0].image == null) {
        return _buildLoadingIndicator(index: 0, context: context);
      }

      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: _buildImageBoxWithChecker(
            context: context,
            isSelected: allImages[0].isSelected,
            isShowCheckIcon: false,
            index: 0,
            child: Image.memory(
              allImages[0].image!,
              height: imageHeight,
              width: imageWidth,
              cacheHeight: imageHeight.cacheSize,
              cacheWidth: imageWidth.cacheSize,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    // More than one image
    return ReorderableGridView.count(
      scrollDirection: Axis.horizontal,
      crossAxisCount: 1,
      mainAxisSpacing: AppSpace.space3,
      childAspectRatio: imageHeight / imageWidth,
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
      onReorder: controller.onReorder,
      onDragStart: (index) => GetIt.I<VibrateUtil>().vibrateSelection(),
      dragWidgetBuilder: (index, child) {
        if (allImages[index].image == null || allImages[index].isTooLarge) {
          return SizedBox.shrink(key: ValueKey('image-preview-$index'));
        }

        final height = imageHeight * 0.95;
        final width = imageWidth * 0.95;
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: const Offset(5, 5),
                blurRadius: 20,
                color: context.theme.appColors.backgroundGrayLighter,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.roundedXl),
            child: Image.memory(
              allImages[index].image!,
              height: height,
              width: width,
              cacheHeight: height.cacheSize,
              cacheWidth: width.cacheSize,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      children: List.generate(allImages.length, (index) {
        final imageFile = allImages[index];

        if (imageFile.isTooLarge) {
          return SizedBox.shrink(key: ValueKey('image-preview-$index'));
        } else if (imageFile.image == null) {
          return _buildLoadingIndicator(index: index, context: context);
        }

        return GestureDetector(
          key: ValueKey('image-preview-$index'),
          onTap: () => controller.onSelected(index),
          child: Container(
            alignment: Alignment.center,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                child: _buildImageBoxWithChecker(
                  context: context,
                  isSelected: imageFile.isSelected,
                  index: index,
                  child: Image.memory(
                    imageFile.image!,
                    height: imageHeight,
                    width: imageWidth,
                    cacheHeight: imageHeight.cacheSize,
                    cacheWidth: imageWidth.cacheSize,
                    fit: BoxFit.cover,
                  ),
                )),
          ),
        );
      }),
    );
  }

  Widget _buildMentionTextField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: AppSpace.space4,
        right: AppSpace.space4,
        bottom: AppSpace.space4,
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space2),
      constraints: const BoxConstraints(
        maxHeight: textFieldHeight,
        maxWidth: double.maxFinite,
      ),
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLightPressed.withValues(alpha: 0.4),
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.roundedFull)),
      ),
      child: MentionTextField(
        key: controller.textFieldGlobalKey,
        focusNode: controller.textFieldFocusNode,
        scrollController: controller.textFieldScrollController,
        suggestionOverlayOffset: const Offset(0, -AppSpace.space2),
        onTap: controller.onKeyboardTap,
        keyboardType: TextInputType.multiline,
        mentions: [controller.mentionMarkModel],
        minLines: 1,
        maxLines: 2,
        maxLength: UChatConstant.maxMessageInputLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        cursorColor: context.theme.appColors.textPrimary,
        style: context.theme.appTexts.body2.copyWith(
          color: context.theme.appColors.textDarkest,
        ),
        decoration: InputDecoration(
          hintText: 'Add your caption'.tr,
          hintStyle: context.theme.appTexts.body2.copyWith(
            color: context.theme.appColors.textDark,
          ),
          contentPadding: const EdgeInsets.only(left: AppSpace.space2, bottom: AppSpace.space2),
          counterText: '',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        inputFormatters: [
          ThaiLengthLimitingTextInputFormatter(
            UChatConstant.maxMessageInputLength,
          ),
        ],
        trailing: Center(
          child: Obx(() {
            final isAllLoaded = controller.isAllLoaded.value && controller.selectedCount.value > 0;

            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: isAllLoaded ? controller.onSend : null,
              child: Opacity(
                opacity: isAllLoaded ? 1 : 0.25,
                child: Assets.vectors.keyboardSend.svg(
                  height: 32,
                  width: 54,
                ),
              ),
            );
          }),
        ),
        contextMenuBuilder: (
          BuildContext context,
          EditableTextState editableTextState,
        ) {
          final buttons = controller.getButtonItems(editableTextState);

          return AdaptiveTextSelectionToolbar.buttonItems(
            anchors: editableTextState.contextMenuAnchors,
            buttonItems: buttons,
          );
        },
      ),
    );
  }

  Widget _buildLoadingIndicator({
    required int index,
    required BuildContext context,
  }) {
    return Obx(
      key: ValueKey('image-preview-$index'),
      () {
        final percentage = controller.allImages[index].percentage;

        return Center(
          child: Container(
            height: imageHeight,
            width: imageWidth,
            decoration: BoxDecoration(
              color: context.theme.appColors.backgroundAudioReceiverPlaying,
              borderRadius: BorderRadius.circular(AppRadius.roundedXl),
            ),
            child: Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: percentage > 0
                    ? CircularPercentIndicator(
                        percent: percentage,
                        animation: true,
                        animationDuration: 100,
                        lineWidth: AppSize.size1,
                        animateFromLastPercent: true,
                        backgroundColor: context.theme.appColors.neutral32,
                        progressColor: context.theme.appColors.backgroundNeutralLightest,
                        radius: 20,
                      )
                    : CircularProgressIndicator(
                        padding: const EdgeInsets.all(2),
                        strokeWidth: AppSize.size1,
                        strokeCap: StrokeCap.round,
                        strokeAlign: 0,
                        backgroundColor: context.theme.appColors.neutral32,
                        valueColor: AlwaysStoppedAnimation<Color>(context.theme.appColors.backgroundNeutralLightest),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageBoxWithChecker({
    required BuildContext context,
    required bool isSelected,
    required Widget child,
    required int index,
    bool isShowCheckIcon = true,
  }) {
    return Stack(
      children: [
        child,
        if (isShowCheckIcon)
          Positioned(
            top: 10,
            right: 10,
            child: UChatRoundCheckBox(
              animationDuration: Duration.zero,
              size: AppSize.size8,
              checkedWidget: Padding(
                padding: const EdgeInsets.all(AppSpace.space1),
                child: Assets.vectors.check12.svg(
                  colorFilter: ColorFilter.mode(
                    context.theme.appColors.iconPrimaryInverse,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              isChecked: isSelected,
              borderColor: isSelected
                  ? context.theme.appColors.backgroundPrimary
                  : context.theme.appColors.backgroundNeutralLightest,
              uncheckedColor: context.theme.appColors.neutral32,
              checkedColor: context.theme.appColors.backgroundPrimary,
              onTap: (isCheck) {
                controller.onSelected(index);
              },
            ),
          ),
      ],
    );
  }
}
