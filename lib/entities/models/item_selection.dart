import 'dart:convert';

class ItemSelection {
  ItemSelection({
    required this.messageId,
    required this.index,
  });

  final String messageId;
  final List<int> index;

  factory ItemSelection.fromJson(String str) => ItemSelection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemSelection.fromMap(Map<String, dynamic> json) => ItemSelection(
        messageId: json['messageId'],
        index: List<int>.from(json['index'].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        'messageId': messageId,
        'index': List<dynamic>.from(index.map((x) => x)),
      };
}
