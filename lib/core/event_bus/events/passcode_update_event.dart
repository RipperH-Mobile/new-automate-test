// TODO (multiple account) Remove this event if unused.
@Deprecated('unused event')
class PasscodeUpdateEvent {
  bool enabled;

  PasscodeUpdateEvent({required this.enabled});

  @override
  String toString() => 'PasscodeUpdateEvent(enabled: $enabled)';
}
