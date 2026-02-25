enum ReportType {
  reportMessage('REPORT_MESSAGE'),
  reportUser('REPORT_USER'),
  reportGroup('REPORT_GROUP'),
  reportBug('REPORT_BUG');

  final String value;

  const ReportType(this.value);
}
