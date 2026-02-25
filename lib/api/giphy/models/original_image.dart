class GiphyOriginalImage {
  final String url;
  final String width;
  final String height;
  final String size;
  final String frames;
  final String mp4;
  final String mp4Size;
  final String? webp;
  final String? webpSize;
  final String hash;

  GiphyOriginalImage({
    required this.url,
    required this.width,
    required this.height,
    required this.size,
    required this.frames,
    required this.mp4,
    required this.mp4Size,
    this.webp,
    this.webpSize,
    required this.hash,
  });

  factory GiphyOriginalImage.fromJson(Map<String, dynamic> json) {
    return GiphyOriginalImage(
        url: json['url'] as String,
        width: json['width'] as String,
        height: json['height'] as String,
        size: json['size'] as String,
        frames: json['frames'] as String,
        mp4: json['mp4'] as String,
        mp4Size: json['mp4_size'] as String,
        webp: json['webp'] as String?,
        webpSize: json['webp_size'] as String?,
        hash: json['hash'] as String);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'url': url,
      'width': width,
      'height': height,
      'size': size,
      'frames': frames,
      'mp4': mp4,
      'mp4_size': mp4Size,
      'webp': webp,
      'webp_size': webpSize,
      'hash': hash
    };
  }

  @override
  String toString() {
    return 'GiphyOriginalImage{url: $url, width: $width, height: $height, size: $size, frames: $frames, mp4: $mp4, mp4Size: $mp4Size, webp: $webp, webpSize: $webpSize, hash: $hash}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GiphyOriginalImage &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          width == other.width &&
          height == other.height &&
          size == other.size &&
          frames == other.frames &&
          mp4 == other.mp4 &&
          mp4Size == other.mp4Size &&
          webp == other.webp &&
          webpSize == other.webpSize &&
          hash == other.hash;

  @override
  int get hashCode =>
      url.hashCode ^
      width.hashCode ^
      height.hashCode ^
      size.hashCode ^
      frames.hashCode ^
      mp4.hashCode ^
      mp4Size.hashCode ^
      webp.hashCode ^
      webpSize.hashCode ^
      hash.hashCode;
}
