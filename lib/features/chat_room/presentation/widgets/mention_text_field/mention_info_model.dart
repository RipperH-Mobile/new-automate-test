// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/rendering.dart';

class MentionInfoModel {
  String id;

  String display;

  String nameValue;

  String userName;

  String fullName;

  String photoUrl;

  TextStyle? style;

  MentionInfoModel({
    required this.id,
    required this.display,
    required this.nameValue,
    required this.userName,
    this.fullName = '',
    this.photoUrl = '',
    this.style,
  });

  MentionInfoModel copyWith({
    String? id,
    String? display,
    String? nameValue,
    String? userName,
    String? fullName,
    String? photoUrl,
    TextStyle? style,
  }) {
    return MentionInfoModel(
      id: id ?? this.id,
      display: display ?? this.display,
      nameValue: nameValue ?? this.nameValue,
      userName: userName ?? this.userName,
      fullName: fullName ?? this.fullName,
      photoUrl: photoUrl ?? this.photoUrl,
      style: style ?? this.style,
    );
  }

  @override
  String toString() {
    return 'MentionInfoModel(id: $id, display: $display, nameValue: $nameValue, userName: $userName, fullName: $fullName, photoUrl: $photoUrl, style: $style)';
  }

  @override
  bool operator ==(covariant MentionInfoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.display == display &&
        other.nameValue == nameValue &&
        other.userName == userName &&
        other.fullName == fullName &&
        other.photoUrl == photoUrl &&
        other.style == style;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        display.hashCode ^
        nameValue.hashCode ^
        userName.hashCode ^
        fullName.hashCode ^
        photoUrl.hashCode ^
        style.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'display': display,
      'nameValue': nameValue,
      'userName': userName,
      'fullName': fullName,
      'photoUrl': photoUrl,
    };
  }

  factory MentionInfoModel.fromMap(Map<String, dynamic> map) {
    return MentionInfoModel(
      id: map['id'] as String,
      display: map['display'] as String,
      nameValue: map['nameValue'] as String,
      userName: map['userName'] as String,
      fullName: map['fullName'] as String,
      photoUrl: map['photoUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MentionInfoModel.fromJson(String source) =>
      MentionInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
