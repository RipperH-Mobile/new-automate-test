import 'package:get/utils.dart';

class EmojiPackageEntity {
  final String? coverId;
  final String? coverImageUrl;
  final DateTime? createdAt;
  final String? description;
  final String? id;
  final bool? isDefault;
  final bool? isPublish;
  final LangModel? name;
  final List<String>? tags;
  final DateTime? updatedAt;

  EmojiPackageEntity({
    this.coverId,
    this.coverImageUrl,
    this.createdAt,
    this.description,
    this.id,
    this.isDefault,
    this.isPublish,
    this.name,
    this.tags,
    this.updatedAt,
  });

  // copyWith
  EmojiPackageEntity copyWith({
    String? coverId,
    String? coverImageUrl,
    DateTime? createdAt,
    String? description,
    String? id,
    bool? isDefault,
    bool? isPublish,
    LangModel? name,
    List<String>? tags,
    DateTime? updatedAt,
  }) {
    return EmojiPackageEntity(
      coverId: coverId ?? this.coverId,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      id: id ?? this.id,
      isDefault: isDefault ?? this.isDefault,
      isPublish: isPublish ?? this.isPublish,
      name: name ?? this.name,
      tags: tags ?? this.tags,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get nameLocale {
    return Get.locale?.languageCode == 'en' ? name?.en ?? '' : name?.th ?? '';
  }

  factory EmojiPackageEntity.fromMap(Map<String, dynamic> json) => EmojiPackageEntity(
        id: json['_id'],
        name: json['name'] == null ? null : LangModel.fromMap(json['name']),
        description: json['description'],
        coverId: json['coverId'],
        tags: json['tags'] == null ? [] : List<String>.from(json['tags']!.map((x) => x)),
        isDefault: json['isDefault'],
        isPublish: json['isPublish'],
        createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
        updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
        coverImageUrl: json['coverImageUrl'],
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name?.toMap(),
        'description': description,
        'coverId': coverId,
        'tags': tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        'isDefault': isDefault,
        'isPublish': isPublish,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'coverImageUrl': coverImageUrl,
      };
}

class LangModel {
  final String? en;
  final String? th;

  LangModel({
    this.en,
    this.th,
  });

  factory LangModel.fromMap(Map<String, dynamic> json) => LangModel(
        en: json['EN'],
        th: json['TH'],
      );

  Map<String, dynamic> toMap() => {
        'EN': en,
        'TH': th,
      };
}
