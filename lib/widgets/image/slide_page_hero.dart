// make hero better when slide out
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class SlidePageHeroWidget extends StatefulWidget {
  final Widget child;
  final SlideType slideType;
  final Object tag;
  final GlobalKey<ExtendedImageSlidePageState> slidePageKey;

  const SlidePageHeroWidget({
    super.key,
    required this.child,
    required this.tag,
    required this.slidePageKey,
    this.slideType = SlideType.onlyImage,
  });

  @override
  HeroWidgetState createState() => HeroWidgetState();
}

class HeroWidgetState extends State<SlidePageHeroWidget> {
  late RectTween _rectTween;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.tag,
      child: widget.child,
      createRectTween: (Rect? begin, Rect? end) {
        _rectTween = RectTween(begin: begin, end: end);
        return _rectTween;
      },
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Hero(
//     tag: widget.tag,
//     createRectTween: (Rect? begin, Rect? end) {
//       _rectTween = RectTween(begin: begin, end: end);
//       return _rectTween;
//     },
//     // make hero better when slide out
//     flightShuttleBuilder: (BuildContext flightContext,
//         Animation<double> animation,
//         HeroFlightDirection flightDirection,
//         BuildContext fromHeroContext,
//         BuildContext toHeroContext) {
//       // make hero more smoothly
//       final Hero hero = (flightDirection == HeroFlightDirection.pop
//           ? fromHeroContext.widget
//           : toHeroContext.widget) as Hero;
//       if (flightDirection == HeroFlightDirection.pop) {
//         final bool fixTransform = widget.slideType == SlideType.onlyImage &&
//             (widget.slidePageKey.currentState!.offset != Offset.zero ||
//                 widget.slidePageKey.currentState!.scale != 1.0);
//
//         final Widget toHeroWidget = (toHeroContext.widget as Hero).child;
//         return AnimatedBuilder(
//           animation: animation,
//           builder: (BuildContext buildContext, Widget? child) {
//             Widget animatedBuilderChild = hero.child;
//
//             // make hero more smoothly
//             animatedBuilderChild = Stack(
//               clipBehavior: Clip.antiAlias,
//               alignment: Alignment.center,
//               children: <Widget>[
//                 Opacity(
//                   opacity: 1 - animation.value,
//                   child: UnconstrainedBox(
//                     child: SizedBox(
//                       width: _rectTween.begin!.width,
//                       height: _rectTween.begin!.height,
//                       child: toHeroWidget,
//                     ),
//                   ),
//                 ),
//                 Opacity(
//                   opacity: animation.value,
//                   child: animatedBuilderChild,
//                 )
//               ],
//             );
//
//             // fix transform when slide out
//             if (fixTransform) {
//               final Tween<Offset> offsetTween = Tween<Offset>(
//                   begin: Offset.zero,
//                   end: widget.slidePageKey.currentState!.offset);
//
//               final Tween<double> scaleTween = Tween<double>(
//                   begin: 1.0, end: widget.slidePageKey.currentState!.scale);
//               animatedBuilderChild = Transform.translate(
//                 offset: offsetTween.evaluate(animation),
//                 child: Transform.scale(
//                   scale: scaleTween.evaluate(animation),
//                   child: animatedBuilderChild,
//                 ),
//               );
//             }
//
//             return animatedBuilderChild;
//           },
//         );
//       }
//       return hero.child;
//     },
//     child: widget.child,
//   );
// }
}
