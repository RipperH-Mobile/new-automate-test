import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uchat/core/event_bus/event_bus.dart';

class UChatSlidableItem extends StatefulWidget {
  final bool disableSlidable;
  final String? groupTag;
  final ActionPane? startActionPane;
  final ActionPane? endActionPane;
  final Widget child;
  final bool enableCloseListener;
  final SlidableController? controller;
  final String? actionPaneId;
  final bool shouldStayOpenActionPane;
  final Function(String? itemId, bool isOpen)? onActionPaneOpenChanged;

  const UChatSlidableItem({
    super.key,
    this.disableSlidable = false,
    this.groupTag,
    this.startActionPane,
    this.endActionPane,
    required this.child,
    this.enableCloseListener = false,
    this.controller,
    this.actionPaneId,
    this.shouldStayOpenActionPane = false,
    this.onActionPaneOpenChanged,
  });

  @override
  State<UChatSlidableItem> createState() => _UChatSlidableItemState();
}

class _UChatSlidableItemState extends State<UChatSlidableItem> with TickerProviderStateMixin {
  late SlidableController _slidableController;
  StreamSubscription? _shouldClosePanel;

  @override
  void initState() {
    super.initState();
    _slidableController = (widget.controller ?? SlidableController(this));
    _slidableController.actionPaneType.addListener(_handleSlidableStateChange);

    _shouldClosePanel = eventBus.on<CloseSlidablePanelEvent>().listen((event) {
      _handleCloseSlidablePanelEvent(event);
    });

    if (widget.shouldStayOpenActionPane) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _slidableController.openEndActionPane();
      });
    }
  }

  @override
  void didUpdateWidget(UChatSlidableItem oldWidget) {
    if (!widget.shouldStayOpenActionPane) {
      _slidableController.close();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  dispose() {
    _shouldClosePanel?.cancel();
    _slidableController.actionPaneType.removeListener(_handleSlidableStateChange);
    _slidableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.key),
      groupTag: widget.groupTag,
      controller: _slidableController,
      enabled: !widget.disableSlidable,
      startActionPane: widget.startActionPane,
      endActionPane: widget.endActionPane,
      child: widget.child,
    );
  }

  void _handleSlidableStateChange() {
    widget.onActionPaneOpenChanged?.call(
      widget.actionPaneId,
      _slidableController.actionPaneType.value != ActionPaneType.none,
    );
  }

  void _handleCloseSlidablePanelEvent(CloseSlidablePanelEvent event) {
    final shouldClose = event.forceClosePanel || widget.enableCloseListener;
    final isActionPaneOpen = _slidableController.actionPaneType.value != ActionPaneType.none;

    if (!shouldClose || !isActionPaneOpen) {
      return;
    }

    _slidableController.close(duration: event.duration).then((_) => setState(() {}));
  }
}
