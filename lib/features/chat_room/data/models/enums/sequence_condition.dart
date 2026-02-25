enum SequenceCondition {
  or('OR'),
  and('AND');

  final String value;
  const SequenceCondition(this.value);
}
