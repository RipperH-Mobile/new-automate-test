import 'package:isar_community/isar.dart';
import 'package:uchat/utils/datetime.dart';

part 'accepted_platform_document.g.dart';

@embedded
class AcceptedPlatformDocument {
  final int? major;
  final int? minor;
  final int? patch;
  final String? type;
  final DateTime? acceptedAt;

  AcceptedPlatformDocument({
    this.major,
    this.minor,
    this.patch,
    this.type,
    this.acceptedAt,
  });

  factory AcceptedPlatformDocument.fromJson(Map<String, dynamic> json) {
    return AcceptedPlatformDocument(
      type: json['type'],
      major: json['version']['major'],
      minor: json['version']['minor'],
      patch: json['version']['patch'],
      acceptedAt: strToDateTime(json['acceptedAt']),
    );
  }
}
