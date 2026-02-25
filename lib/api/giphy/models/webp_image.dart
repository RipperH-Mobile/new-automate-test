class GiphyWebPImage {
  final String url;
  final String width;
  final String height;
  final String size;

  GiphyWebPImage({
    required this.url,
    required this.width,
    required this.height,
    required this.size,
  });

  factory GiphyWebPImage.fromJson(Map<String, dynamic> json) {
    return GiphyWebPImage(
      url: json['url'] as String,
      width: json['width'] as String,
      height: json['height'] as String,
      size: json['size'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'url': url, 'width': width, 'height': height, 'size': size};
  }

  @override
  String toString() {
    return 'GiphyWebPImage{url: $url, width: $width, height: $height, size: $size}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GiphyWebPImage &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          width == other.width &&
          height == other.height &&
          size == other.size;

  @override
  int get hashCode => url.hashCode ^ width.hashCode ^ height.hashCode ^ size.hashCode;
}
