class GiphyPreviewImage {
  final String width;
  final String height;
  final String? mp4;
  final String? mp4Size;

  GiphyPreviewImage({
    required this.width,
    required this.height,
    this.mp4,
    this.mp4Size,
  });

  factory GiphyPreviewImage.fromJson(Map<String, dynamic> json) {
    return GiphyPreviewImage(
      width: json['width'] as String,
      height: json['height'] as String,
      mp4: json['mp4'] as String?,
      mp4Size: json['mp4_size'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'width': width, 'height': height, 'mp4': mp4, 'mp4_size': mp4Size};
  }

  @override
  String toString() {
    return 'GiphyPreviewImage{width: $width, height: $height, mp4: $mp4, mp4Size: $mp4Size}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GiphyPreviewImage &&
          runtimeType == other.runtimeType &&
          width == other.width &&
          height == other.height &&
          mp4 == other.mp4 &&
          mp4Size == other.mp4Size;

  @override
  int get hashCode => width.hashCode ^ height.hashCode ^ mp4.hashCode ^ mp4Size.hashCode;
}
