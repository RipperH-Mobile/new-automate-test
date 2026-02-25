import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

/// A common tooltip widget that wraps the super_tooltip package
/// Provides a consistent tooltip experience across the app
class AppTooltip extends StatefulWidget {
  /// The child widget that triggers the tooltip
  final Widget child;

  /// The text content to display in the tooltip
  final String text;

  /// Background color of the tooltip (defaults to theme surface color)
  final Color? backgroundColor;

  /// Text color of the tooltip content (defaults to theme text color)
  final Color? textColor;

  /// Direction where the tooltip should appear
  final TooltipDirection popupDirection;

  /// Whether to show a barrier behind the tooltip
  final bool showBarrier;

  /// Color of the barrier (only applies when showBarrier is true)
  final Color? barrierColor;

  /// Callback when tooltip is shown
  final VoidCallback? onShow;

  /// Callback when tooltip is dismissed
  final VoidCallback? onDismiss;

  /// Whether the tooltip is enabled (defaults to true)
  final bool enabled;

  /// Custom text style for the tooltip content
  final TextStyle? textStyle;

  /// Padding inside the tooltip content
  final EdgeInsets? contentPadding;

  /// Border radius of the tooltip
  final double? borderRadius;

  /// Elevation/shadow of the tooltip
  final double? elevation;

  const AppTooltip._internal({
    super.key,
    required this.child,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.popupDirection = TooltipDirection.down,
    this.showBarrier = false,
    this.barrierColor,
    this.onShow,
    this.onDismiss,
    this.enabled = true,
    this.textStyle,
    this.contentPadding,
    this.borderRadius,
    this.elevation,
  });

  /// Default tooltip with basic styling
  factory AppTooltip({
    Key? key,
    required Widget child,
    required String text,
    Color? backgroundColor,
    Color? textColor,
    TooltipDirection popupDirection = TooltipDirection.down,
    bool showBarrier = false,
    Color? barrierColor,
    VoidCallback? onShow,
    VoidCallback? onDismiss,
    bool enabled = true,
    TextStyle? textStyle,
    EdgeInsets? contentPadding,
    double? borderRadius,
    double? elevation,
  }) {
    return AppTooltip._internal(
      key: key,
      text: text,
      backgroundColor: backgroundColor,
      textColor: textColor,
      popupDirection: popupDirection,
      showBarrier: showBarrier,
      barrierColor: barrierColor,
      onShow: onShow,
      onDismiss: onDismiss,
      enabled: enabled,
      textStyle: textStyle,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
      elevation: elevation,
      child: child,
    );
  }

  /// Simple tooltip with minimal parameters
  factory AppTooltip.simple({
    Key? key,
    required Widget child,
    required String text,
    TooltipDirection popupDirection = TooltipDirection.down,
    bool enabled = true,
  }) {
    return AppTooltip._internal(
      key: key,
      text: text,
      popupDirection: popupDirection,
      showBarrier: true,
      enabled: enabled,
      child: child,
    );
  }

  /// Tooltip with custom styling
  factory AppTooltip.styled({
    Key? key,
    required Widget child,
    required String text,
    Color? backgroundColor,
    Color? textColor,
    TooltipDirection popupDirection = TooltipDirection.down,
    double? borderRadius,
    double? elevation,
    bool enabled = true,
  }) {
    return AppTooltip._internal(
      key: key,
      text: text,
      backgroundColor: backgroundColor,
      textColor: textColor,
      popupDirection: popupDirection,
      showBarrier: false,
      enabled: enabled,
      borderRadius: borderRadius ?? 8.0,
      elevation: elevation ?? 4.0,
      child: child,
    );
  }

  @override
  State<AppTooltip> createState() => _AppTooltipState();
}

class _AppTooltipState extends State<AppTooltip> {
  final SuperTooltipController _tooltipController = SuperTooltipController();

  @override
  void dispose() {
    _tooltipController.dispose();
    super.dispose();
  }

  void _showTooltip() async {
    if (!widget.enabled) return;

    await _tooltipController.showTooltip();
    widget.onShow?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return GestureDetector(
      onTap: _showTooltip,
      child: SuperTooltip(
        hideTooltipOnTap: true,
        onHide: widget.onDismiss,
        controller: _tooltipController,
        popupDirection: widget.popupDirection,
        showBarrier: widget.showBarrier,
        barrierColor: widget.barrierColor ?? Colors.black.withValues(alpha: 0.1),
        backgroundColor: widget.backgroundColor ?? Colors.black,
        content: Container(
          padding: widget.contentPadding ?? const EdgeInsets.all(AppSpace.space2),
          child: AppText.body2(
            widget.text,
            context: context,
            color: widget.textColor ?? context.theme.appColors.textPrimaryInverse,
          ),
        ),
        arrowTipDistance: AppSpace.space4,
        arrowBaseWidth: AppSize.size4,
        arrowLength: AppSize.size2,
        borderRadius: widget.borderRadius ?? AppRadius.roundedXl,
        elevation: widget.elevation ?? AppSize.size1,
        shadowColor: Colors.black.withValues(alpha: 0.2),
        child: widget.child,
      ),
    );
  }
}

/// Extension methods for easy tooltip integration
extension TooltipExtension on Widget {
  /// Wraps the widget with a simple tooltip
  Widget withTooltip(String text, {
    TooltipDirection direction = TooltipDirection.down,
    bool enabled = true,
    Key? key,
  }) {
    return AppTooltip.simple(
      key: key,
      text: text,
      popupDirection: direction,
      enabled: enabled,
      child: this,
    );
  }

  /// Wraps the widget with a styled tooltip
  Widget withStyledTooltip(String text, {
    Color? backgroundColor,
    Color? textColor,
    TooltipDirection direction = TooltipDirection.down,
    double? borderRadius,
    double? elevation,
    bool enabled = true,
    Key? key,
  }) {
    return AppTooltip.styled(
      key: key,
      text: text,
      backgroundColor: backgroundColor,
      textColor: textColor,
      popupDirection: direction,
      borderRadius: borderRadius,
      elevation: elevation,
      enabled: enabled,
      child: this,
    );
  }
}