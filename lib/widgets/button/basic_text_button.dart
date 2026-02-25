// import 'package:flutter/material.dart';
// import 'package:uchat/core/theme/app_space.dart';

// class BasicTextButton extends StatelessWidget {
//   final void Function()? onPressed;
//   final void Function()? onLongPress;
//   final Widget child;
//   final EdgeInsets? padding;

//   const BasicTextButton({
//     super.key,
//     required this.child,
//     this.onPressed,
//     this.onLongPress,
//     this.padding,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: onPressed,
//       onLongPress: onLongPress,
//       style: ButtonStyle(
//         padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
//           padding ?? const EdgeInsets.symmetric(horizontal: AppSpace.space4),
//         ),
//       ),
//       child: child,
//     );
//   }
// }
