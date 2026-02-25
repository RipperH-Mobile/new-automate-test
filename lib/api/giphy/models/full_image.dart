class GiphyFullImage {
  final String url;
  final String width;
  final String height;
  final String size;
  final String? mp4;
  final String? mp4Size;
  final String? webp;
  final String? webpSize;

  GiphyFullImage({
    required this.url,
    required this.width,
    required this.height,
    required this.size,
    this.mp4,
    this.mp4Size,
    this.webp,
    this.webpSize,
  });

  factory GiphyFullImage.fromJson(Map<String, dynamic> json) => GiphyFullImage(
      url: json['url'] as String,
      width: json['width'] as String,
      height: json['height'] as String,
      size: json['size'] as String,
      mp4: json['mp4'] as String?,
      mp4Size: json['mp4_size'] as String?,
      webp: json['webp'] as String?,
      webpSize: json['webp_size'] as String?);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'url': url,
      'width': width,
      'height': height,
      'size': size,
      'mp4': mp4,
      'mp4_size': mp4Size,
      'webp': webp,
      'webp_size': webpSize
    };
  }

  @override
  String toString() {
    return 'GiphyFullImage{url: $url, width: $width, height: $height, size: $size, mp4: $mp4, mp4Size: $mp4Size, webp: $webp, webpSize: $webpSize}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GiphyFullImage &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          width == other.width &&
          height == other.height &&
          size == other.size &&
          mp4 == other.mp4 &&
          mp4Size == other.mp4Size &&
          webp == other.webp &&
          webpSize == other.webpSize;

  @override
  int get hashCode =>
      url.hashCode ^
      width.hashCode ^
      height.hashCode ^
      size.hashCode ^
      mp4.hashCode ^
      mp4Size.hashCode ^
      webp.hashCode ^
      webpSize.hashCode;
}
