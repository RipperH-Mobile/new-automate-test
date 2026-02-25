import 'dart:math' as math;
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/widgets/animation/widget_bouncing.dart';

enum PressType {
  longPress,
  singleClick,
}

enum PreferredPosition {
  top,
  bottom,
}

class CustomPopupMenuController extends ChangeNotifier {
  bool menuIsShowing = false;

  void showMenu() {
    // This prevent from opening multiple popup from the same message
    if (menuIsShowing) {
      return;
    }
    menuIsShowing = true;
    notifyListeners();
  }

  void hideMenu() {
    menuIsShowing = false;
    notifyListeners();
  }

  void toggleMenu() {
    menuIsShowing = !menuIsShowing;
    notifyListeners();
  }
}

class CustomPopupMenu extends StatefulWidget {
  const CustomPopupMenu({
    super.key,
    required this.child,
    required this.menuBuilder,
    required this.pressType,
    this.controller,
    this.arrowColor = const Color(0xFF4C4C4C),
    this.showArrow = true,
    this.barrierColor = Colors.black12,
    this.arrowSize = 10.0,
    this.horizontalMargin = 10.0,
    this.verticalMargin = 10.0,
    this.position,
    this.menuOnChange,
  });

  final Widget child;
  final PressType pressType;
  final bool showArrow;
  final Color arrowColor;
  final Color barrierColor;
  final double horizontalMargin;
  final double verticalMargin;
  final double arrowSize;
  final CustomPopupMenuController? controller;
  final Widget menuBuilder;
  final PreferredPosition? position;
  final void Function(bool)? menuOnChange;

  @override
  CustomPopupMenuState createState() => CustomPopupMenuState();
}

class CustomPopupMenuState extends State<CustomPopupMenu> {
  RenderBox? _childBox;
  RenderBox? _parentBox;
  OverlayEntry? _overlayEntry;
  CustomPopupMenuController? _controller;

  _showMenu() {
    Widget arrow = ClipPath(
      clipper: _ArrowClipper(),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          width: widget.arrowSize,
          height: widget.arrowSize,
          color: widget.arrowColor.withValues(alpha: 0.6),
        ),
      ),
    );

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return FadeIn(
          duration: const Duration(milliseconds: 50),
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _controller?.hideMenu();
                },
                child: Container(
                  color: widget.barrierColor,
                ),
              ),
              Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: _parentBox!.size.width - 2 * widget.horizontalMargin,
                    minWidth: 0,
                  ),
                  child: CustomMultiChildLayout(
                    delegate: _MenuLayoutDelegate(
                      anchorSize: _childBox!.size,
                      anchorOffset: _childBox!.localToGlobal(
                        Offset(-widget.horizontalMargin, 0),
                      ),
                      verticalMargin: widget.verticalMargin,
                      position: widget.position,
                    ),
                    children: <Widget>[
                      // LayoutId(
                      //   id: _MenuLayoutId.content,
                      //   child: Column(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: <Widget>[
                      //       Material(
                      //         child: widget.menuBuilder(),
                      //         color: Colors.transparent,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      if (widget.showArrow)
                        LayoutId(
                          id: _MenuLayoutId.arrow,
                          child: arrow,
                        ),
                      if (widget.showArrow)
                        LayoutId(
                          id: _MenuLayoutId.downArrow,
                          child: Transform.rotate(
                            angle: math.pi,
                            child: arrow,
                          ),
                        ),
                      LayoutId(
                        id: _MenuLayoutId.content,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            widget.menuBuilder,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (_overlayEntry != null) {
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  _hideMenu() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  _updateView() {
    bool menuIsShowing = _controller?.menuIsShowing ?? false;
    widget.menuOnChange?.call(menuIsShowing);
    if (menuIsShowing) {
      _showMenu();
    } else {
      _hideMenu();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller ?? CustomPopupMenuController();
    _controller?.addListener(_updateView);
    WidgetsBinding.instance.addPostFrameCallback((call) {
      if (mounted) {
        _childBox = context.findRenderObject() as RenderBox?;
        _parentBox = Overlay.of(context).context.findRenderObject() as RenderBox?;
      }
    });
  }

  @override
  void dispose() {
    _hideMenu();
    _controller?.removeListener(_updateView);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var child = Material(
      color: Colors.transparent,
      child: BouncingGesture(
        child: widget.child,
        onTap: () {
          if (widget.pressType == PressType.singleClick) {
            _controller?.showMenu();
          }
        },
        onLongTap: () {
          if (widget.pressType == PressType.longPress) {
            _controller?.showMenu();
          }
        },
      ),
    );
    if (GetPlatform.isIOS) {
      return child;
    } else {
      return PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          _hideMenu();
        },
        child: child,
      );
    }
  }
}

enum _MenuLayoutId {
  arrow,
  downArrow,
  content,
}

enum _MenuPosition {
  bottomLeft,
  bottomCenter,
  bottomRight,
  topLeft,
  topCenter,
  topRight,
}

class _MenuLayoutDelegate extends MultiChildLayoutDelegate {
  _MenuLayoutDelegate({
    required this.anchorSize,
    required this.anchorOffset,
    required this.verticalMargin,
    this.position,
  });

  final Size anchorSize;
  final Offset anchorOffset;
  final double verticalMargin;
  final PreferredPosition? position;

  @override
  void performLayout(Size size) {
    Size contentSize = Size.zero;
    Size arrowSize = Size.zero;
    Offset contentOffset = const Offset(0, 0);
    Offset arrowOffset = const Offset(0, 0);

    double anchorCenterX = anchorOffset.dx + anchorSize.width / 2;
    double anchorTopY = anchorOffset.dy;
    double anchorBottomY = anchorTopY + anchorSize.height;
    _MenuPosition menuPosition = _MenuPosition.bottomCenter;

    if (hasChild(_MenuLayoutId.content)) {
      contentSize = layoutChild(
        _MenuLayoutId.content,
        BoxConstraints.loose(size),
      );
    }
    if (hasChild(_MenuLayoutId.arrow)) {
      arrowSize = layoutChild(
        _MenuLayoutId.arrow,
        BoxConstraints.loose(size),
      );
    }
    if (hasChild(_MenuLayoutId.downArrow)) {
      layoutChild(
        _MenuLayoutId.downArrow,
        BoxConstraints.loose(size),
      );
    }

    bool isTop = false;
    if (position == null) {
      // auto calculate position
      isTop = anchorBottomY > size.height / 2 &&
          anchorTopY > Get.mediaQuery.padding.top + kToolbarHeight + contentSize.height;
    } else {
      isTop = position == PreferredPosition.top;
    }
    if (anchorCenterX - contentSize.width / 2 < 0) {
      menuPosition = isTop ? _MenuPosition.topLeft : _MenuPosition.bottomLeft;
    } else if (anchorCenterX + contentSize.width / 2 > size.width) {
      menuPosition = isTop ? _MenuPosition.topRight : _MenuPosition.bottomRight;
    } else {
      menuPosition = isTop ? _MenuPosition.topCenter : _MenuPosition.bottomCenter;
    }

    switch (menuPosition) {
      case _MenuPosition.bottomCenter:
        arrowOffset = Offset(
          anchorCenterX - arrowSize.width / 2,
          anchorBottomY + verticalMargin - 15,
        );
        contentOffset = Offset(
          anchorCenterX - contentSize.width / 2,
          anchorBottomY + verticalMargin + arrowSize.height - 15,
        );
        break;
      case _MenuPosition.bottomLeft:
        arrowOffset = Offset(anchorCenterX - arrowSize.width / 2, anchorBottomY + verticalMargin - 15);
        contentOffset = Offset(
          0,
          anchorBottomY + verticalMargin + arrowSize.height - 15,
        );
        break;
      case _MenuPosition.bottomRight:
        arrowOffset = Offset(anchorCenterX - arrowSize.width / 2, anchorBottomY + verticalMargin - 15);
        contentOffset = Offset(
          size.width - contentSize.width,
          anchorBottomY + verticalMargin + arrowSize.height - 15,
        );
        break;
      case _MenuPosition.topCenter:
        arrowOffset = Offset(
          anchorCenterX - arrowSize.width / 2,
          anchorTopY - verticalMargin - arrowSize.height + 10,
        );
        contentOffset = Offset(
          anchorCenterX - contentSize.width / 2,
          anchorTopY - verticalMargin - arrowSize.height - contentSize.height + 10,
        );
        break;
      case _MenuPosition.topLeft:
        arrowOffset = Offset(
          anchorCenterX - arrowSize.width / 2,
          anchorTopY - verticalMargin - arrowSize.height + 10,
        );
        contentOffset = Offset(
          0,
          anchorTopY - verticalMargin - arrowSize.height - contentSize.height + 10,
        );
        break;
      case _MenuPosition.topRight:
        arrowOffset = Offset(
          anchorCenterX - arrowSize.width / 2,
          anchorTopY - verticalMargin - arrowSize.height + 10,
        );
        contentOffset = Offset(
          size.width - contentSize.width,
          anchorTopY - verticalMargin - arrowSize.height - contentSize.height + 10,
        );
        break;
    }
    if (hasChild(_MenuLayoutId.content)) {
      positionChild(_MenuLayoutId.content, contentOffset);
    }
    bool isBottom = false;
    if (_MenuPosition.values.indexOf(menuPosition) < 3) {
      // bottom
      isBottom = true;
    }
    if (hasChild(_MenuLayoutId.arrow)) {
      positionChild(
        _MenuLayoutId.arrow,
        isBottom ? Offset(arrowOffset.dx, arrowOffset.dy + 0.1) : const Offset(-100, 0),
      );
    }
    if (hasChild(_MenuLayoutId.downArrow)) {
      positionChild(
        _MenuLayoutId.downArrow,
        !isBottom ? Offset(arrowOffset.dx, arrowOffset.dy - 0.1) : const Offset(-100, 0),
      );
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) => false;
}

class _ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, size.height / 2);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
