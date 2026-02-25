import 'dart:convert';

class ChatGptResponse {
  String id;
  String object;
  String model;
  DateTime created;
  List<ChatGptChoice> choices;
  ChatGptUsage usage;

  ChatGptResponse({
    required this.id,
    required this.object,
    required this.model,
    required this.created,
    this.choices = const [],
    required this.usage,
  });

  factory ChatGptResponse.fromJson(Map<String, dynamic> json) {
    return ChatGptResponse(
      id: json['id'],
      object: json['object'],
      model: json['model'],
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000, isUtc: true),
      choices: List<ChatGptChoice>.from(json['choices'].map((choice) => ChatGptChoice.fromJson(choice))),
      usage: ChatGptUsage.fromJson(json['usage']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': object,
      'model': model,
      'created': created.millisecond,
      'choices': choices.map((choice) => choice.toJson()).toList(),
      'usage': usage.toJson(),
    };
  }

  @override
  String toString() {
    return 'ChatGptResponse{id: $id, object: $object, model: $model, created: $created, choices: $choices, usage: $usage}';
  }
}

class ChatGptChoice {
  int index;
  ChatGptChoiceMessage message;
  String finishReason;

  ChatGptChoice({
    required this.index,
    required this.message,
    required this.finishReason,
  });

  factory ChatGptChoice.fromJson(Map<String, dynamic> json) {
    return ChatGptChoice(
      index: json['index'],
      message: ChatGptChoiceMessage.fromJson(json['message']),
      finishReason: json['finish_reason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'message': message.toJson(),
      'finish_reason': finishReason,
    };
  }
}

class ChatGptChoiceMessage {
  String role;
  String content;

  ChatGptChoiceMessage({
    required this.role,
    required this.content,
  });

  factory ChatGptChoiceMessage.fromJson(Map<String, dynamic> json) {
    return ChatGptChoiceMessage(
      role: json['role'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }

  Map<String, dynamic> getContentMap() {
    final RegExp jsonRegex = RegExp(r'{[\s\S]*}');
    final match = jsonRegex.firstMatch(content);

    if (match == null) {
      throw FormatException('Could not find JSON in response');
    }

    final jsonResult = match.group(0)!.trim().replaceAll(RegExp(r'^\uFEFF'), '');

    return jsonDecode(jsonResult);
  }
}

class ChatGptUsage {
  int promptTokens;
  int completionTokens;
  int totalTokens;

  ChatGptUsage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory ChatGptUsage.fromJson(Map<String, dynamic> json) {
    return ChatGptUsage(
      promptTokens: json['prompt_tokens'],
      completionTokens: json['completion_tokens'],
      totalTokens: json['total_tokens'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prompt_tokens': promptTokens,
      'completion_tokens': completionTokens,
      'total_tokens': totalTokens,
    };
  }
}
