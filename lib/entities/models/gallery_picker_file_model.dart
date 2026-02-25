// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import '../enum/message_file_type.dart';
import 'file_info_model.dart';

class GalleryPickerFileModel {
  /// to get [File] from [imagesAssetEntityId] or [videosAssetEntityId]
  /// final id = imagesAssetEntityId.first;
  /// final asset = await AssetEntity.fromId(id);
  /// final file = await asset?.file;

  final List<FileInfoModel> fileInfoList;

  GalleryPickerFileModel({
    required this.fileInfoList,
  });

  GalleryPickerFileModel copyWith({
    List<FileInfoModel>? fileInfoList,
  }) {
    return GalleryPickerFileModel(
      fileInfoList: fileInfoList ?? this.fileInfoList,
    );
  }

  @override
  String toString() => 'GalleryPickerFileModel(mediaFiles: $fileInfoList)';

  List<FileInfoModel> get videos => fileInfoList.where((element) => element.type == MessageFileType.video).toList();

  List<FileInfoModel> get images => fileInfoList.where((element) => element.type == MessageFileType.image).toList();
}
