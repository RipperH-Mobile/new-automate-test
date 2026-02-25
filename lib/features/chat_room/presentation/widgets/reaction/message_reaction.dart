import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_dimensions.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/domain/entities/last_emoji_entity.dart';
import 'package:uchat/features/chat_room/presentation/controllers/reaction/message_reaction_controller.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class MessageReaction extends GetView<MessageReactionController> {
  final String messageTag;
  final bool enableReactionModal;

  const MessageReaction({
    super.key,
    required this.messageTag,
    required this.enableReactionModal,
  });

  @override
  String get tag => messageTag;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if ((controller.message.value?.canReact ?? false) && controller.message.value?.lastEmojis?.isNotEmpty == true) {
          return Padding(
            padding: EdgeInsets.only(
              top: UChatDimensions.messageReactionBoxMargin,
            ),
            child: GestureDetector(
              onTap: () {
                if (enableReactionModal) {
                  controller.showMsgReactionModal(context);
                }
              },
              child: _SeparatedBox(
                // ignore: invalid_use_of_protected_member
                emojiIdAnimates: controller.emojiIdAnimates.value,
                emojiAmount: controller.message.value?.emojiAmount ?? 0,
                lastEmojiList: controller.message.value?.lastEmojis ?? [],
                selectedReactions: controller.message.value?.selectedReactionList ?? [],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class _SeparatedBox extends StatelessWidget {
  const _SeparatedBox({
    // required this.reactionList,
    // required this.reactCount,
    // required this.animate,
    required this.lastEmojiList,
    required this.emojiAmount,
    required this.selectedReactions,
    required this.emojiIdAnimates,
  });

  // final List<ReactionCategoriesWithAnimation> reactionList;
  // final int reactCount;
  // final bool animate;

  final List<LastEmojiEntity> lastEmojiList;
  final int emojiAmount;
  final List<String> selectedReactions;
  final List<String> emojiIdAnimates;

  @override
  Widget build(BuildContext context) {
    final userId = UserController.instance.currentUser.value?.id;

    bool showMore = false;
    if (emojiAmount > 5) {
      showMore = true;
    }

    return Wrap(
      spacing: AppSpace.space2,
      runSpacing: AppSpace.space2,
      children: [
        ...lastEmojiList.map(
          (element) {
            return _SeparatedBoxItem(
              emojiIdAnimates: emojiIdAnimates,
              key: ValueKey('reaction_${element.emojiId}_${element.fileId}'),
              lastEmojiEntity: element,
              selected: element.accountIds?.contains(userId) == true,
            );
          },
        ),
        if (showMore)
          _ReactionBox(
            showBorder: true,
            child: Icon(
              Icons.chevron_right_rounded,
              color: context.theme.appColors.icon,
              size: UChatDimensions.messageReactionEmojiSize,
            ),
          ),
      ],
      // children: list.map(
      //   (element) {
      //     return _SeparatedBoxItem(
      //       key: UniqueKey(),
      //       lastEmojiEntity: element,
      //       // reactionCategoriesModel: element,
      //       // animate: animate,
      //       // animationController: element.reactionBoxAnimationController,
      //     );
      //   },
      // ).toList(),
    );
  }
}

class _SeparatedBoxItem extends StatefulWidget {
  const _SeparatedBoxItem({
    super.key,
    // required this.reactionCategoriesModel,
    // required this.animate,
    // required this.animationController,
    required this.lastEmojiEntity,
    required this.selected,
    required this.emojiIdAnimates,
  });

  // final ReactionCategoriesWithAnimation reactionCategoriesModel;
  // final bool animate;
  // final AnimationController animationController;

  final LastEmojiEntity lastEmojiEntity;
  final bool selected;
  final List<String> emojiIdAnimates;

  @override
  State<_SeparatedBoxItem> createState() => _SeparatedBoxItemState();
}

class _SeparatedBoxItemState extends State<_SeparatedBoxItem> with SingleTickerProviderStateMixin {
  // CurvedAnimation? _animation;

  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.animate) {
  //     _animation = CurvedAnimation(
  //       parent: widget.animationController,
  //       curve: UchatCurves.messageReactionCurve,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final reactionCategory = widget.reactionCategoriesModel.reactionCategoriesModel;
    // final showAccountList = reactionCategory.accountList != null && reactionCategory.amount! < 3;
    final fileId = widget.lastEmojiEntity.fileId;
    final amount = widget.lastEmojiEntity.amount;

    if (fileId == null || fileId.isEmpty || amount == null || amount <= 0) {
      return const SizedBox.shrink();
    }

    final child = _ReactionBox(
      showBorder: widget.selected,
      showBackground: widget.selected,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpace.space1,
        children: [
          _Emoji(
            key: ValueKey('emoji_${widget.lastEmojiEntity.emojiId}_$fileId'),
            fileId: fileId,
            animate: widget.emojiIdAnimates.contains(widget.lastEmojiEntity.emojiId),
          ),
          AppText.caption2Bold(
            context: context,
            '$amount',
            lineHeight: 1,
          )
        ],
      ),
    );
    // if (widget.animate && _animation != null) {
    //   return AnimatedBuilder(
    //     animation: _animation!,
    //     builder: (context, _) {
    //       return Transform.scale(
    //         scale: _animation!.value,
    //         child: child,
    //       );
    //     },
    //   );
    // } else {
    //   return child;
    // }
    return child;
  }
}

class _ReactionBox extends StatelessWidget {
  const _ReactionBox({
    required this.child,
    this.showBorder = false,
    this.showBackground = false,
  });

  final Widget child;
  final bool showBorder;
  final bool showBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: UChatDimensions.messageReactionBoxPadding,
        horizontal: AppSpace.space2,
      ),
      decoration: BoxDecoration(
        color: showBackground
            ? context.theme.appColors.backgroundNeutralLighterPressed
            : context.theme.appColors.backgroundNeutralLightest,
        borderRadius: BorderRadius.circular(AppRadius.roundedFull),
        border: showBorder
            ? Border.all(
                color: context.theme.appColors.backgroundNeutralLightPressed,
                width: UChatDimensions.messageReactionBorderWidth,
              )
            : null,
      ),
      child: child,
    );
  }
}

class _Emoji extends StatefulWidget {
  const _Emoji({
    super.key,
    required this.fileId,
    this.animate = false,
  });

  final String fileId;
  final bool animate;

  @override
  State<_Emoji> createState() => _EmojiState();
}

class _EmojiState extends State<_Emoji> {
  bool _shouldAnimate = false;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _shouldAnimate = widget.animate;
  }

  @override
  void didUpdateWidget(_Emoji oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Only trigger animation if it's new and we haven't animated before
    if (widget.animate && !oldWidget.animate && !_hasAnimated) {
      setState(() {
        _shouldAnimate = true;
        _hasAnimated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = UChatImage.network(
      FileService.instance.getEmojiUrl(widget.fileId),
      width: UChatDimensions.messageReactionEmojiSize,
      height: UChatDimensions.messageReactionEmojiSize,
      customLoadingWidget: (p0) => ShimmerLoading(
        enable: true,
        child: _buildCustomCircle(),
      ),
      customErrorWidget: (p0) => ShimmerLoading(
        enable: true,
        child: _buildCustomCircle(),
      ),
    );

    if (_shouldAnimate) {
      double animatedHeight = 35.0;
      double maxScale = 0.25;

      double minPos = 0.40;
      double peakPos = 0.60;

      return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 1200),
        curve: Curves.linear,
        // Using linear here since we'll apply curves per phase
        builder: (context, value, child) {
          double scaleValue;
          double translateY;

          if (value <= minPos) {
            // Phase 1: Move up animatedHeight px and scale from 0 to (1.0 + maxScale) with fastToSlow curve
            final phaseProgress = value / minPos;
            // Apply fastToSlow curve (decelerate - starts fast, ends slow)
            final curvedProgress = Curves.decelerate.transform(phaseProgress);

            scaleValue = curvedProgress * (1.0 + maxScale); // 0 to (1.0 + maxScale)
            translateY = -animatedHeight * curvedProgress; // 0 to -animatedHeight
          } else if (value <= peakPos) {
            // Phase 2: Stay at peak for delay (40% to 60%)
            scaleValue = 1.0 + maxScale;
            translateY = -animatedHeight;
          } else {
            // Phase 3: Move back down and scale from (1.0 + maxScale) to 1.0 with fastAndBounce curve
            final phaseProgress = (value - peakPos) / (1.0 - peakPos);
            // Apply fastAndBounce curve (bounceOut - starts fast and bounces)
            final curvedProgress = Curves.bounceOut.transform(phaseProgress);

            scaleValue = (1.0 + maxScale) - (maxScale * curvedProgress); // (1.0 + maxScale) to 1.0
            translateY = -animatedHeight * (1.0 - curvedProgress); // -animatedHeight to 0
          }

          return Transform.translate(
            offset: Offset(0, translateY),
            child: Transform.scale(
              scale: scaleValue.clamp(0.0, (1.0 + maxScale)),
              child: child,
            ),
          );
        },
        child: child,
      );
    }

    return child;
  }

  Widget _buildCustomCircle() {
    return Container(
      width: UChatDimensions.messageReactionEmojiSize,
      height: UChatDimensions.messageReactionEmojiSize,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}

class AnimatedScaleAndFloat extends StatefulWidget {
  final Widget child;
  final AnimationController controller;

  const AnimatedScaleAndFloat({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<AnimatedScaleAndFloat> createState() => _AnimatedScaleAndFloatState();
}

class _AnimatedScaleAndFloatState extends State<AnimatedScaleAndFloat> with SingleTickerProviderStateMixin {
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _scaleAnimation = Tween<double>(begin: 1, end: 2).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Curves.easeOutExpo,
      ),
    );

    _floatAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -1.8)).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Curves.easeOutExpo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _floatAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
