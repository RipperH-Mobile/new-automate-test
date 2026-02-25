import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';

class ScaffoldBottomButtonContainer extends StatelessWidget {
  final Widget child;

  const ScaffoldBottomButtonContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: UTheme.color.appBar,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          child: child,
        ),
      ),
    );
  }
}
