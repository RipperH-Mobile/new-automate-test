import 'package:isar_community/isar.dart';

part 'mention_model.g.dart';

@embedded
class MentionModel {
  final String? id;
  final String? accountId;
  final String? accountName;
  final String? messageMatch;

  MentionModel({
    this.id,
    this.accountId,
    this.accountName,
    this.messageMatch,
  });

  factory MentionModel.fromMap(Map<String, dynamic> json) {
    return MentionModel(
      id: json['_id'],
      accountId: json['accountId'],
      accountName: json['accountName'],
      messageMatch: json['messageMatch'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'accountId': accountId,
      'accountName': accountName,
      'messageMatch': messageMatch,
    };
  }

  Map<String, dynamic> toMap() => {
        '_id': id,
        'accountId': accountId,
        'accountName': accountName,
        'messageMatch': messageMatch,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MentionModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          accountId == other.accountId &&
          accountName == other.accountName &&
          messageMatch == other.messageMatch;

  @override
  int get hashCode => id.hashCode ^ accountId.hashCode ^ accountName.hashCode ^ messageMatch.hashCode;

  @override
  String toString() {
    return 'MentionModel (id: $id, '
        'accountId: $accountId, '
        'accountName: $accountName, '
        'messageMatch: $messageMatch)';
  }
}
