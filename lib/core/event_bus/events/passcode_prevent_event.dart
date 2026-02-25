class PasscodePreventEvent {
  bool preventActivate;

  PasscodePreventEvent({required this.preventActivate});

  @override
  String toString() => 'PasscodePreventEvent(preventActivate: $preventActivate)';
}
