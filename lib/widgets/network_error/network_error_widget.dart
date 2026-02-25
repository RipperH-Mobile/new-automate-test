import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/app_button_size.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';

/// A reusable widget that displays a network error state with a retry button.
///
/// This widget reacts to the connectivity state and shows an error message
/// when the device is offline. It provides a customizable interface for
/// displaying network errors across different screens.
///
/// Example usage:
/// ```dart
/// // Without child (uses SizedBox.shrink() when online)
/// NetworkErrorWidget(
///   context: context,
///   onRetry: () => controller.retryAction(),
/// )
///
/// // With child (displays child when online)
/// NetworkErrorWidget(
///   context: context,
///   onRetry: () => controller.retryAction(),
///   child: YourNormalContentWidget(),
/// )
/// ```
class NetworkErrorWidget extends StatelessWidget {
  /// Creates a network error widget.
  ///
  /// [context] is the build context (required).
  /// [onRetry] is the callback function to execute when the retry button is pressed (required).
  /// [title] is the title text to display. Defaults to 'A network error occurred.'.tr
  /// [message] is the detailed message text. Defaults to 'Connection issue. \nPlease check and try again.'.tr
  /// [buttonLabel] is the label for the retry button. Defaults to 'Retry'.tr
  /// [icon] is the icon to display on the retry button. Defaults to Assets.vectors.iconRetry.svg()
  /// [enableShowError] determines if the widget should only show when offline. Defaults to true.
  /// [child] is the widget to display when the network is online. If null, returns SizedBox.shrink().
  const NetworkErrorWidget({
    super.key,
    required this.context,
    required this.onRetry,
    this.title = 'A network error occurred.',
    this.message = 'Connection issue. \nPlease check and try again.',
    this.buttonLabel = 'Retry',
    this.icon,
    this.enableShowError = true,
    this.child,
  });

  /// The build context for this widget.
  final BuildContext context;

  /// Callback function to execute when the retry button is pressed.
  final VoidCallback onRetry;

  /// Title text to display above the message.
  final String title;

  /// Detailed message text explaining the connection issue.
  final String message;

  /// Label for the retry button.
  final String buttonLabel;

  /// Icon to display on the retry button.
  final Widget? icon;

  /// If true, always shows the error state. If false only shows child.
  final bool enableShowError;

  /// The widget to display. If null, returns SizedBox.shrink().
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return enableShowError
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText.body2Bold(
                title.tr,
                context: context,
                color: context.theme.appColors.textDark,
              ),
              const SizedBox(height: AppSpace.space05),
              AppText.body4(
                message.tr,
                context: context,
                color: context.theme.appColors.textLight,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpace.space4),
              AppFilledButton.dark(
                context: context,
                onTap: onRetry,
                icon: icon ?? Assets.vectors.iconRetry.svg(),
                label: buttonLabel.tr,
                isExpanded: false,
                size: AppButtonSize.medium,
              ),
              const SizedBox(height: kToolbarHeight * 1.5, width: double.infinity),
            ],
          )
        : child ?? const SizedBox.shrink();
  }
}
