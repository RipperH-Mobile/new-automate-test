enum ReportTopic {
  spam('SPAM'),
  violence('VIOLENCE'),
  pornography('PORNOGRAPHY'),
  childAbuse('CHILD_ABUSE'),
  copyRight('COPYRIGHT'),
  other('OTHER');

  final String value;
  const ReportTopic(this.value);
}
