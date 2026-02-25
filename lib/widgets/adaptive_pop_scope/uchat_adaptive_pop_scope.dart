import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';

class UChatAdaptivePopScope extends StatefulWidget {
  final Widget child;
  final bool shouldAddCallback;
  final Future<bool> Function() onWillPop;

  const UChatAdaptivePopScope({
    super.key,
    required this.child,
    required this.onWillPop,
    this.shouldAddCallback = true,
  });

  @override
  State<UChatAdaptivePopScope> createState() => _UChatAdaptivePopScopeState();
}

class _UChatAdaptivePopScopeState extends State<UChatAdaptivePopScope> {
  @override
  Widget build(BuildContext context) {
    return ConditionalWillPopScope(
      onWillPop: () async {
        final result = await widget.onWillPop();
        return result;
      },
      shouldAddCallback: widget.shouldAddCallback,
      child: widget.child,
    );
  }
}
