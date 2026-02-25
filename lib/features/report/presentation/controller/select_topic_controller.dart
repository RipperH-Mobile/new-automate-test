import 'package:get/get.dart';
import 'package:uchat/features/report/data/models/enum/report_topic.dart';

class SelectTopicController extends GetxController {
  var selectedTopic = ReportTopic.spam.obs;
  var count = 0.obs;
  increment() => count++;

  List<String> get reportTopics {
    List<String> topics = [];
    for (var value in ReportTopic.values) {
      topics.add(value.text);
    }

    return topics;
  }

  void init() {
    selectedTopic.value = ReportTopic.spam;
  }

  set setSelectedTopic(ReportTopic topic) {
    selectedTopic.value = topic;
  }
}
