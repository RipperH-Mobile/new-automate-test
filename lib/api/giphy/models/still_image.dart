class GiphyStillImage {
  final String url;
  final String width;
  final String height;
  final String size;

  GiphyStillImage({
    required this.url,
    required this.width,
    required this.height,
    required this.size,
  });

  factory GiphyStillImage.fromJson(Map<String, dynamic> json) => GiphyStillImage(
      url: json['url'] as String,
      width: json['width'] as String,
      height: json['height'] as String,
      size: json['size'] as String);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'url': url, 'width': width, 'height': height, 'size': size};
  }

  @override
  String toString() {
    return 'GiphyStillImage{url: $url, width: $width, height: $height, size: $size}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GiphyStillImage &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          width == other.width &&
          height == other.height &&
          size == other.size;

  @override
  int get hashCode => url.hashCode ^ width.hashCode ^ height.hashCode ^ size.hashCode;
}
