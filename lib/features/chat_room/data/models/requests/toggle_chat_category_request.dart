import 'package:uchat/entities/models.dart';

class ToggleChatCategoryRequest {
  final ChatSettingsModel? chat;

  ToggleChatCategoryRequest({required this.chat});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {
      'chat': {
        'showCategory': chat?.showCategory,
      },
    };

    return json;
  }
}
