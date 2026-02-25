import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/utils/vibrate.dart';
// import 'package:uchat/widgets/animation/widget_bouncing.dart';

class TwoElementScaleSwitcher extends StatefulWidget {
  final Future<void> Function()? parentAction;
  final void Function()? onLongTap;
  final Widget firstElement;
  final Widget secondElement;
  final BoxDecoration boxDecoration;
  final BoxConstraints parentBoxConstraints;
  final Color bgColor;
  final bool ensureEnableRef;

  const TwoElementScaleSwitcher({
    super.key,
    required this.firstElement,
    required this.secondElement,
    required this.parentBoxConstraints,
    this.boxDecoration = const BoxDecoration(),
    this.parentAction,
    this.bgColor = Colors.transparent,
    this.onLongTap,
    this.ensureEnableRef = false,
  });

  @override
  TwoElementScaleSwitcherState createState() => TwoElementScaleSwitcherState();
}

class TwoElementScaleSwitcherState extends State<TwoElementScaleSwitcher> with SingleTickerProviderStateMixin {
  bool _isFirstIcon = true;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Widget firstWidget;
  late Widget secondWidget;
  Color bgColor = Colors.transparent;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    bgColor = widget.bgColor;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    if (!widget.ensureEnableRef) {
      firstWidget = widget.secondElement;
      secondWidget = widget.firstElement;
    } else {
      firstWidget = widget.firstElement;
      secondWidget = widget.secondElement;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        GetIt.I<VibrateUtil>().vibrateSelection();
        widget.parentAction?.call();
        if (_isFirstIcon) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        setState(() {
          _isFirstIcon = !_isFirstIcon;
        });
      },
      // BouncingGesture(
      // bouncingDurationMilliseconds: 0,
      // isActionWidgetUpdateEnable: false,
      // onTap: () async {
      //   if (widget.parentAction != null) {
      //     await vibrateSelection();
      //     setState(() {
      //       bgColor = Colors.transparent;
      //       Future.delayed(const Duration(milliseconds: 150), () {
      //         if (mounted) {
      //           setState(() {
      //             bgColor = widget.bgColor;
      //           });
      //         }
      //       });
      //     });
      //     if (_isFirstIcon) {
      //       await _controller.forward();
      //     } else {
      //       await _controller.reverse();
      //     }
      //     _isFirstIcon = !_isFirstIcon;
      //     await Future.delayed(const Duration(milliseconds: 150), () {});
      //     await widget.parentAction?.call();
      //   }
      // },
      // onLongTap: widget.onLongTap,
      // upperBound: 0.2,
      // isConcurrency: false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        constraints: widget.parentBoxConstraints,
        // width: double.infinity,
        // height: double.infinity,
        decoration: widget.boxDecoration.copyWith(color: bgColor),
        child: Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: _animation.value,
              filterQuality: FilterQuality.high,
              child: firstWidget,
            ),
            Transform.scale(
              scale: 1 - _animation.value,
              filterQuality: FilterQuality.high,
              child: secondWidget,
            ),
          ],
        ),
      ),
    );
  }
}
