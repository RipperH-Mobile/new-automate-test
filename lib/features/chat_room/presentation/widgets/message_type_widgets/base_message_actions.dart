import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

/// Base mixin for message actions to share common functionality
mixin BaseMessageActions {
  static const double height = 48.0;

  /// Common message action box widget
  Widget messageActionBox({
    required String text,
    required SvgGenImage icon,
    VoidCallback? onTap,
    bool isDestructiveAction = false,
  }) {
    return Material(
      color: Get.context?.theme.scaffoldBackgroundColor,
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap();
            HapticFeedback.heavyImpact();
          }
        },
        // splashColor: Get.context?.theme.appColors.textPrimary.withOpacity(0.1),
        // highlightColor: Get.context?.theme.appColors.textPrimary.withOpacity(0.05),
        child: SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.button2(
                  text,
                  context: Get.context!,
                  color: isDestructiveAction
                      ? Get.context?.theme.appColors.textError
                      : Get.context?.theme.appColors.textDarkest,
                ),
                icon.svg(
                  colorFilter: ColorFilter.mode(
                    isDestructiveAction ? Get.context!.theme.appColors.iconError : Get.context!.theme.appColors.icon,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Common copy action
  Widget buildCopy({VoidCallback? onCopy}) {
    return messageActionBox(
      onTap: onCopy,
      text: 'Copy'.tr,
      icon: Assets.vectors.contentCopy,
    );
  }

  /// Common share action
  Widget buildShare({VoidCallback? onShare}) {
    return messageActionBox(
      onTap: onShare,
      text: 'Share'.tr,
      icon: Assets.vectors.share06,
    );
  }

  /// Common unpin action
  Widget buildUnpin({VoidCallback? onUnPin}) {
    return messageActionBox(
      onTap: onUnPin,
      text: 'Unpin'.tr,
      icon: Assets.vectors.iconUnpin,
    );
  }

  /// Common pin action
  Widget buildPin({VoidCallback? onPin}) {
    return messageActionBox(
      onTap: onPin,
      text: 'Pin'.tr,
      icon: Assets.vectors.pin,
    );
  }

  /// Common reply action
  Widget buildReply({VoidCallback? onReply}) {
    return messageActionBox(
      onTap: onReply,
      text: 'Reply'.tr,
      icon: Assets.vectors.reply,
    );
  }

  /// Common edit action
  Widget buildEdit({VoidCallback? onEdit}) {
    return messageActionBox(
      onTap: onEdit,
      text: 'Edit'.tr,
      icon: Assets.vectors.pencilLine,
    );
  }

  /// Common unsent action
  Widget buildUnsent({VoidCallback? onUnsent}) {
    return messageActionBox(
      onTap: onUnsent,
      text: 'Unsend'.tr,
      icon: Assets.vectors.unsend,
      isDestructiveAction: true,
    );
  }

  /// Common delete action
  Widget buildDelete({VoidCallback? onDelete}) {
    return messageActionBox(
      onTap: onDelete,
      text: 'Delete'.tr,
      icon: Assets.vectors.trash,
      isDestructiveAction: true,
    );
  }

  /// Common delete other message action
  Widget buildDeleteOtherMsg({VoidCallback? onDeleteOtherMsg}) {
    return messageActionBox(
      onTap: onDeleteOtherMsg,
      text: 'Delete for all'.tr,
      icon: Assets.vectors.unsend,
      isDestructiveAction: true,
    );
  }

  /// Common report action
  Widget buildReport({VoidCallback? onReport}) {
    return messageActionBox(
      onTap: onReport,
      text: 'Report'.tr,
      icon: Assets.vectors.warning,
    );
  }

  /// Common resend failed message action
  Widget buildResendFailedMessage({VoidCallback? onResendFailedMessage}) {
    return messageActionBox(
      onTap: onResendFailedMessage,
      text: 'Resend'.tr,
      icon: Assets.vectors.resendNoBorder,
    );
  }

  /// Common remove failed message action
  Widget buildRemoveFailedMessage({VoidCallback? onRemoveFailedMessage}) {
    return messageActionBox(
      onTap: onRemoveFailedMessage,
      text: 'Delete'.tr,
      icon: Assets.vectors.trash,
      isDestructiveAction: true,
    );
  }

  /// Common add to album action
  Widget buildAddToAlbum({VoidCallback? onAddToAlbum}) {
    return messageActionBox(
      onTap: onAddToAlbum,
      text: 'Album'.tr,
      icon: Assets.vectors.iconAddToAlbum,
    );
  }
}
