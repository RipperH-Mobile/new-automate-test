import 'package:get/get.dart';

enum ReportTopic {
  spam('SPAM'),
  harassment('HARASSMENT'),
  inappropriateContent('INAPPROPRIATE_CONTENT'),
  other('OTHER');

  final String value;

  get textTranslate {
    switch (this) {
      case ReportTopic.spam:
        return 'Spam'.tr;
      case ReportTopic.harassment:
        return 'Harassment'.tr;
      case ReportTopic.inappropriateContent:
        return 'Inappropriate Content'.tr;
      case ReportTopic.other:
        return 'Other'.tr;
    }
  }

  get text {
    switch (this) {
      case ReportTopic.spam:
        return 'Spam'.tr;
      case ReportTopic.harassment:
        return 'Harassment'.tr;
      case ReportTopic.inappropriateContent:
        return 'Inappropriate Content'.tr;
      case ReportTopic.other:
        return 'Other'.tr;
    }
  }

  static fromText(String text) {
    return ReportTopic.values.firstWhere((element) => element.text == text);
  }

  const ReportTopic(this.value);
}
