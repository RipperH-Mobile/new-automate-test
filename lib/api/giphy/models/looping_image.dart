class GiphyLoopingImage {
  final String mp4;
  final String mp4Size;

  GiphyLoopingImage({
    required this.mp4,
    required this.mp4Size,
  });

  factory GiphyLoopingImage.fromJson(Map<String, dynamic> json) =>
      GiphyLoopingImage(mp4: json['mp4'] as String, mp4Size: json['mp4_size'] as String);

  Map<String, dynamic> toJson() => <String, dynamic>{'mp4': mp4, 'mp4_size': mp4Size};

  @override
  String toString() {
    return 'GiphyLoopingImage{mp4: $mp4, mp4Size: $mp4Size}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GiphyLoopingImage && runtimeType == other.runtimeType && mp4 == other.mp4 && mp4Size == other.mp4Size;

  @override
  int get hashCode => mp4.hashCode ^ mp4Size.hashCode;
}
