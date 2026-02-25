import 'package:flutter/foundation.dart';
import 'package:uchat/api/giphy/models/gif.dart';

@immutable
class GifSendingEntity {
  final String gifUrl;
  final String giphyId;
  final String? mp4;
  final String? webp;
  final double? width;
  final double? height;

  const GifSendingEntity({
    required this.gifUrl,
    required this.giphyId,
    this.mp4,
    this.webp,
    this.width,
    this.height,
  });

  factory GifSendingEntity.fromGiphyGif(GiphyGif giphyGif) {
    final original = giphyGif.images!.original!;

    String gifUrl = original.url;
    String? gifWebPUrl = original.webp;
    String giphyId = giphyGif.id;
    String? gifMp4Url = original.mp4;
    double? width = double.parse(original.width);
    double? height = double.parse(original.height);

    return GifSendingEntity(
      gifUrl: gifUrl,
      webp: gifWebPUrl,
      mp4: gifMp4Url,
      giphyId: giphyId,
      width: width,
      height: height,
    );
  }
}
