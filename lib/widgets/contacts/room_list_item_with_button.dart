import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';

class RoomListItemWithButton<M> extends StatelessWidget {
  final void Function()? onPressed;
  final void Function()? onItemPressed;
  final M data;
  final bool showStatusMessage;
  final bool showMemberCount;
  final bool useGravatar;
  final EdgeInsets? padding;
  final String? buttonText;
  final Color? backgroundButtonColor;
  final Color? customBackgroundColor;
  final Color? textInButtonColor;
  final Color? borderButtonColor;
  final BorderRadius? borderRadiusButton;
  final Size? sizeButton;
  final Widget? customText;
  final Widget? child;

  const RoomListItemWithButton({
    super.key,
    this.onPressed,
    this.onItemPressed,
    required this.data,
    this.showStatusMessage = true,
    this.showMemberCount = true,
    this.useGravatar = false,
    this.padding,
    this.buttonText,
    this.backgroundButtonColor,
    this.textInButtonColor,
    this.borderButtonColor,
    this.borderRadiusButton,
    this.sizeButton,
    this.customBackgroundColor,
    this.customText,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemPressed,
      child: ContactListItem<M>(
        data: data,
        useGravatar: useGravatar,
        showStatusMessage: showStatusMessage,
        showMemberCount: showMemberCount,
        customBackgroundColor: customBackgroundColor,
        customText: customText,
        actions: [
          child != null
              ? child!
              : Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: TextButton(
                    onPressed: () {
                      if (onPressed != null) {
                        onPressed!();
                      }
                    },
                    style: ButtonStyle(
                      minimumSize: sizeButton != null ? WidgetStateProperty.all(sizeButton) : null,
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: borderRadiusButton ?? BorderRadius.circular(12),
                          side: borderButtonColor != null
                              ? BorderSide(
                                  color: borderButtonColor!,
                                  width: 1,
                                )
                              : BorderSide.none,
                        ),
                      ),
                      backgroundColor: backgroundButtonColor != null
                          ? WidgetStateProperty.all(
                              backgroundButtonColor?.withValues(alpha: onPressed == null ? 0.5 : 1),
                            )
                          : WidgetStateProperty.all(
                              UTheme.color.primary.withValues(alpha: onPressed == null ? 0.5 : 1),
                            ),
                    ),
                    child: buttonText != null
                        ? Text(
                            '$buttonText',
                            style: TextStyle(
                              color: textInButtonColor ?? const Color(0xFF0056FF),
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Text(
                            onPressed == null ? 'Accepted'.tr : 'Accept'.tr,
                            style: TextStyle(
                              color: UTheme.color.background.withValues(alpha: onPressed == null ? 0.5 : 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
        ],
      ),
    );
  }
}
