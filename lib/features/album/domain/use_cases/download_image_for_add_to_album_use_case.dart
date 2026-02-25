import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/features/album/domain/params/download_image_for_add_to_album_param.dart';
import 'package:uchat/use_cases/use_case.dart';

class DownloadImageForAddToAlbumUseCase extends SimpleUseCase<List<String>, DownloadImageForAddToAlbumParam> {
  HttpCaller get httpCaller {
    return GetIt.I<HttpCaller>();
  }

  @override
  Future<List<String>> call(DownloadImageForAddToAlbumParam params) async {
    List<String> filePathList = [];
    Directory tempDir = await getTemporaryDirectory();
    Directory albumTempDir = Directory('${tempDir.path}/album_temp');
    if (await albumTempDir.exists()) {
      // Clear old temp data.
      await albumTempDir.delete(recursive: true);
    }
    for (final url in params.imagesUrl) {
      /// Download file from url.
      final resp = await httpCaller.get(
        url,
        isExternalApi: true,
        options: Options(
          responseType: ResponseType.bytes,
          headers: httpCaller.apiHeader,
          receiveTimeout: const Duration(seconds: UChatConstant.albumImageUploadTimeout),
        ),
        onReceiveProgress: (int count, int total) {},
      );

      if (resp.data != null) {
        /// Write file data to local storage.
        File file = File('${tempDir.path}/album_temp/${DateTime.now().millisecondsSinceEpoch}.jpg');
        await file.create(recursive: true);
        await file.writeAsBytes(resp.data!);
        filePathList.add(file.path);
      }
    }

    return filePathList;
  }
}
