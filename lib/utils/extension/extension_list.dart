import 'dart:io';

import 'package:camera/camera.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/features/media_gallery/media_gallery.dart';

extension FileListExtension on List<File> {
  /// Convert list of [File] to list of [FileInfoModel]
  /// with `async` operation and sort by order of the file [Ascending, 0-9]
  Future<List<FileInfoModel>> toFileInfoList() async {
    List<File> files = this;
    List<FileInfoModel> fileInfoList = [];
    List<Future> futures = [];
    for (var i = 0; i < files.length; i++) {
      futures.add(
        FileInfoModel.fromFile(files[i], i).then((value) {
          fileInfoList.add(value);
        }),
      );
    }
    await Future.wait(futures);
    fileInfoList.sort((a, b) => a.order.compareTo(b.order));

    return fileInfoList;
  }
}

extension MediaAssetListExtension on List<MediaAsset> {
  /// Convert list of [File] to list of [FileInfoModel]
  /// with `async` operation and sort by order of the file [Ascending, 0-9]
  /// forceTypeFile: if true, Force all items in the list to be type file
  List<FileInfoModel> toFileInfoList({bool forceTypeFile = false}) {
    List<MediaAsset> assets = this;
    List<FileInfoModel> fileInfoList = [];
    for (var i = 0; i < assets.length; i++) {
      fileInfoList.add(FileInfoModel.fromMediaGallery(assets[i], i, forceTypeFile: forceTypeFile));
    }
    fileInfoList.sort((a, b) => a.order.compareTo(b.order));

    return fileInfoList;
  }
}

extension XFileListExtension on List<XFile> {
  /// Convert list of [File] to list of [FileInfoModel]
  /// with `async` operation and sort by order of the file [Ascending, 0-9]
  Future<List<FileInfoModel>> toFileInfoList() async {
    List<XFile> files = this;
    List<FileInfoModel> fileInfoList = [];
    List<Future> futures = [];
    for (var i = 0; i < files.length; i++) {
      final file = File(files[i].path);
      futures.add(
        FileInfoModel.fromFile(file, i).then((value) {
          fileInfoList.add(value);
        }),
      );
    }
    await Future.wait(futures);
    fileInfoList.sort((a, b) => a.order.compareTo(b.order));

    return fileInfoList;
  }
}

extension UChatListExtension<T> on List<T> {
  List<List<T>> splitToGroup(int groupSize) {
    final list = this;
    final List<List<T>> groups = [];
    int length = list.length;
    int index = 0;

    while (index < length) {
      var group = list.skip(index).take(groupSize);
      index += groupSize;
      groups.add(group.toList());
    }
    return groups;
  }
}
