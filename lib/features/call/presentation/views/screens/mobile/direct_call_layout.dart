import 'package:flutter/material.dart';

class DirectCallLayout extends StatelessWidget {
  final Widget? actionsControl;
  final Widget body;
  final PreferredSizeWidget? appBar;

  const DirectCallLayout({
    super.key,
    this.actionsControl,
    required this.body,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: appBar,
      body: body,
      backgroundColor: const Color(0xFF09090B), // TODO: fix color
      bottomNavigationBar: actionsControl != null
          ? SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: actionsControl!,
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
