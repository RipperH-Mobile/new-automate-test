import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';

class RectangleButton extends StatefulWidget {
  final void Function()? onPressed;
  final Color buttonColor;
  final Color? buttonOverlayColor;
  final String? title;
  final Widget? child;
  final TextStyle textStyle;
  final Border? customBorder;
  final bool isEnableScaleAnimation;

  const RectangleButton({
    super.key,
    required this.buttonColor,
    required this.title,
    required this.textStyle,
    this.onPressed,
    this.buttonOverlayColor,
    this.child,
    this.customBorder,
    this.isEnableScaleAnimation = true,
  });

  @override
  State<RectangleButton> createState() => _RectangleButtonState();
}

class _RectangleButtonState extends State<RectangleButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onPressed == null) {
          return;
        }

        if (!_isPressed) {
          setState(() => _isPressed = true);
          widget.onPressed?.call(); // Call the actual onPressed function

          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) {
              setState(() => _isPressed = false);
            }
          });
        }
      },
      child: widget.isEnableScaleAnimation ? _buildTextAnimateContainer() : _buildTextContainer(),
    );
  }

  Widget _buildTextAnimateContainer() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      // Animate background color
      decoration: BoxDecoration(
        color: widget.onPressed == null
            ? widget.buttonColor
            : _isPressed
                ? widget.buttonColor.withAlpha(64) // Darker when pressed
                : widget.buttonColor,
        border: widget.customBorder ??
            Border.all(
              width: AppSize.sizePx,
              color: context.theme.appColors.border,
            ),
      ),
      child: _buildTextButton(
        child: AnimatedScale(
          scale: _isPressed ? AppSize.size05 : AppSize.sizePx,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          child: Center(
            child: widget.title != null ? _buildText() : widget.child,
          ),
        ),
      ),
    );
  }

  Widget _buildTextContainer() {
    return Container(
      decoration: BoxDecoration(
        color: widget.onPressed == null
            ? widget.buttonColor
            : _isPressed
                ? widget.buttonColor.withAlpha(64) // Darker when pressed
                : widget.buttonColor,
        border: widget.customBorder ??
            Border.all(
              width: AppSize.sizePx,
              color: context.theme.appColors.border,
            ),
      ),
      child: _buildTextButton(
        child: Center(
          child: widget.title != null ? _buildText() : widget.child,
        ),
      ),
    );
  }

  Widget _buildTextButton({
    required Widget child,
  }) {
    return TextButton(
      onPressed: null,
      style: TextButton.styleFrom(
        foregroundColor: widget.buttonOverlayColor ?? context.theme.appColors.backgroundNeutralLightest,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      child: child,
    );
  }

  Widget _buildText() {
    return Text(
      widget.title ?? '',
      style: widget.textStyle,
    );
  }
}
