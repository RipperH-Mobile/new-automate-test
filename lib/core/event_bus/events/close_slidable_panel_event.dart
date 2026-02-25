class CloseSlidablePanelEvent {
  final bool forceClosePanel;
  final Duration duration;

  CloseSlidablePanelEvent({
    this.forceClosePanel = false,
    this.duration = const Duration(milliseconds: 100),
  });

  @override
  String toString() => 'CloseSlidablePanelEvent(forceClosePanel: $forceClosePanel, duration: ${duration.inMilliseconds}ms)';
}
