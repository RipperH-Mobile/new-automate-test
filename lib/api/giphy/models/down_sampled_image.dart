class GiphyDownSampledImage {
  final String url;
  final String width;
  final String height;
  final String size;
  final String? webp;
  final String? webpSize;

  GiphyDownSampledImage({
    required this.url,
    required this.width,
    required this.height,
    required this.size,
    this.webp,
    this.webpSize,
  });

  factory GiphyDownSampledImage.fromJson(Map<String, dynamic> json) {
    return GiphyDownSampledImage(
        url: json['url'] as String,
        width: json['width'] as String,
        height: json['height'] as String,
        size: json['size'] as String,
        webp: json['webp'] as String?,
        webpSize: json['webp_size'] as String?);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'url': url,
      'width': width,
      'height': height,
      'size': size,
      'webp': webp,
      'webp_size': webpSize
    };
  }

  @override
  String toString() {
    return 'GiphyDownSampledImage{url: $url, width: $width, height: $height, size: $size, webp: $webp, webpSize: $webpSize}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GiphyDownSampledImage &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          width == other.width &&
          height == other.height &&
          size == other.size &&
          webp == other.webp &&
          webpSize == other.webpSize;

  @override
  int get hashCode =>
      url.hashCode ^ width.hashCode ^ height.hashCode ^ size.hashCode ^ webp.hashCode ^ webpSize.hashCode;
}
