class HiddenAccountUpdateEvent {
  final bool isHidden;
  final String accountId;

  HiddenAccountUpdateEvent({
    required this.isHidden,
    required this.accountId,
  });
}
