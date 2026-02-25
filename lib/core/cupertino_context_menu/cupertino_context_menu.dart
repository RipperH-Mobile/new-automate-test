import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_context_menu/super_context_menu.dart' as super_cupertino;
import 'package:uchat/core/cupertino_context_menu/cupertino_context_menu_widget.dart' as widget_context_menu;

/// Flutter code sample for [CupertinoContextMenu].
class ContextMenuApp extends StatelessWidget {
  const ContextMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: ContextMenuExample(),
    );
  }
}

class ContextMenuExample extends StatefulWidget {
  const ContextMenuExample({super.key});

  @override
  State<ContextMenuExample> createState() => _ContextMenuExampleState();
}

class _ContextMenuExampleState extends State<ContextMenuExample> {
  double multipleWidth = 0.2;
  double multipleHeight = 0.3;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('CupertinoContextMenu Sample'),
        trailing: IconButton(
            onPressed: () {
              setState(() {
                double min = 0.15;
                double max = 1.0;
                multipleHeight = min + Random().nextDouble() * (max - min);
                multipleWidth = min + Random().nextDouble() * (max - min);
              });
            },
            icon: const Icon(Icons.switch_access_shortcut)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  20,
                  (i) => ContextMenuWidget(
                    actions: [],
                    width: Get.width * multipleWidth,
                    height: Get.height * multipleHeight,
                    child: Image.network(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContextMenuWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final Widget child;
  final Widget? topWidget;
  final double? topWidgetHeight; // Height of the top widget, used for calculating total height
  final Widget? bottomWidget;
  final double? bottomWidgetHeight; // Height of the bottom widget, used for calculating total height
  final Widget? previewChild;
  final List<Widget> actions; // List of CupertinoContextMenuAction
  final Alignment? forceAlignment;
  final BoxConstraints? childBoxConstraints;
  final widget_context_menu.LongPressCallback? longPressCallback;

  const ContextMenuWidget({
    super.key,
    this.width,
    this.height,
    required this.child,
    required this.actions,
    this.topWidget,
    this.topWidgetHeight,
    this.bottomWidget,
    this.bottomWidgetHeight,
    this.previewChild,
    this.forceAlignment,
    this.childBoxConstraints,
    this.longPressCallback,
  });

  @override
  State<ContextMenuWidget> createState() => _ContextMenuWidgetState();
}

class _ContextMenuWidgetState extends State<ContextMenuWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.actions.isEmpty) {
      return widget.child;
    }

    return itemBuilder(
      context,
      width: widget.width ?? 0,
      height: widget.height ?? 0,
    );
  }

  Widget itemBuilderSuper({
    required double width,
    required double height,
  }) {
    return super_cupertino.ContextMenuWidget(
      deferredPreviewBuilder: (a, b, c) {
        return super_cupertino.DeferredMenuPreview(
          Size(width, height),
          Future.value(
            b,
          ),
        );
      },
      // liftBuilder: (a, b) {
      //   return const Item(
      //     child: Text('Base Context Menu222'),
      //   );
      // },
      child: widget.child,
      menuProvider: (_) {
        return super_cupertino.Menu(
          children: [
            super_cupertino.MenuAction(
              title: 'Menu Item 1',
              callback: () {},
              image: super_cupertino.MenuImage.icon(Icons.add),
            ),
            super_cupertino.MenuAction(title: 'Menu Item 2', callback: () {}),
            super_cupertino.MenuAction(title: 'Menu Item 3', callback: () {}),
            super_cupertino.MenuSeparator(),
            super_cupertino.Menu(
              title: 'Submenu',
              children: [
                super_cupertino.MenuAction(title: 'Submenu Item 1', callback: () {}),
                super_cupertino.MenuAction(title: 'Submenu Item 2', callback: () {}),
                super_cupertino.Menu(
                  title: 'Nested Submenu',
                  children: [
                    super_cupertino.MenuAction(title: 'Submenu Item 1', callback: () {}),
                    super_cupertino.MenuAction(title: 'Submenu Item 2', callback: () {}),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget itemBuilder(
    BuildContext context, {
    required double width,
    required double height,
  }) {
    return widget_context_menu.CupertinoContextMenu.builder(
      forceAlignment: widget.forceAlignment,
      childBoxConstraints: widget.childBoxConstraints,
      childHeight: height,
      childWidth: width,
      enableHapticFeedback: true,
      topWidget: widget.topWidget,
      topWidgetHeight: widget.topWidgetHeight ?? 0,
      bottomWidget: widget.bottomWidget,
      bottomWidgetHeight: widget.bottomWidgetHeight ?? 0,
      actions: widget.actions,
      longPressCallback: widget.longPressCallback,
      builder: (BuildContext context, Animation<double> animation) {
        // final Animation<BorderRadius?> borderRadiusAnimation = BorderRadiusTween(
        //   begin: BorderRadius.circular(0.0),
        //   end: BorderRadius.circular(CupertinoContextMenu.kOpenBorderRadius),
        // ).animate(
        //   CurvedAnimation(
        //     parent: animation,
        //     curve: Interval(
        //       CupertinoContextMenu.animationOpensAt,
        //       1.0,
        //     ),
        //   ),
        // );

        // final Animation<Decoration> boxDecorationAnimation = DecorationTween(
        //   begin: const BoxDecoration(
        //     boxShadow: <BoxShadow>[],
        //   ),
        //   end: const BoxDecoration(
        //     boxShadow: CupertinoContextMenu.kEndBoxShadow,
        //   ),
        // ).animate(CurvedAnimation(
        //   parent: animation,
        //   curve: Interval(
        //     0.0,
        //     CupertinoContextMenu.animationOpensAt,
        //   ),
        // ));

        return IgnorePointer(
          ignoring: animation.value >= 1,
          child: widget.child,
        );
        // return AnimatedContainer(
        //   duration: Duration(seconds: 1),
        //   // decoration: animation.value < custom_cupertino.CupertinoContextMenu.animationOpensAt
        //   //     ? boxDecorationAnimation.value
        //   //     : null,
        //
        //   child: Stack(
        //     alignment: Alignment.bottomCenter,
        //     fit: StackFit.expand,
        //     children: [
        //       Wrap(
        //         alignment: WrapAlignment.end,
        //         runAlignment: WrapAlignment.center,
        //         crossAxisAlignment: WrapCrossAlignment.center,
        //         direction: Axis.vertical,
        //         children: [
        //           // if (animation.value >= 1 && c.maxHeight < Get.height * 0.45) ...[
        //           //   reactMessage(Colors.yellow),
        //           // ],
        //           SingleChildScrollView(
        //             physics: NeverScrollableScrollPhysics(),
        //             reverse: true,
        //             child: Container(
        //               width: width,
        //               height: height,
        //               decoration: BoxDecoration(borderRadius: borderRadiusAnimation.value),
        //               child: widget.child,
        //             ),
        //           ),
        //         ],
        //       ),
        //       // if (animation.value >= 1 && c.maxHeight >= Get.height * 0.45)
        //       //   Positioned(top: 30, left: 0, right: 0, child: reactMessage(Colors.red))
        //     ],
        //   ),
        // );
      },
    );
  }

  Widget reactMessage(Color bgColor) {
    return FadeIn(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
        child: Container(
          decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                  6,
                  (i) => CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Center(
                        child: Icon(
                          Icons.face,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
