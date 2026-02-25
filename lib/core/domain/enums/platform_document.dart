enum PlatformDocumentType {
  termAndCondition('TERM_AND_CONDITION'),
  privacyPolicy('PRIVACY'),
  termAndConditionWithPrivacy('TERM_AND_CONDITION_PRIVACY');

  final String value;

  const PlatformDocumentType(this.value);
}
