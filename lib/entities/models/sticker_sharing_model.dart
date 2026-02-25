import 'package:isar_community/isar.dart';

part 'sticker_sharing_model.g.dart';

@embedded
class StickerSharingModel {
  final String? packId;
  final String? name;
  final String? description;
  final String? coverId;

  StickerSharingModel({
    this.name,
    this.description,
    this.coverId,
    this.packId,
  });

  static StickerSharingModel fromMap(Map<String, dynamic> data) {
    return StickerSharingModel(
      name: data['name'],
      packId: data['stickerId'],
      description: data['description'],
      coverId: data['coverId'],
    );
  }

  @override
  bool operator ==(Object other) {
    return other is StickerSharingModel && packId == other.packId;
  }

  @override
  int get hashCode => packId.hashCode;
}
