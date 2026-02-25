class ReorderStickerModel {
  final List<ReorderStickerData> data;

  ReorderStickerModel({
    required this.data,
  });

  factory ReorderStickerModel.fromJson(List<dynamic> json) {
    return ReorderStickerModel(
      data: json.map((item) => ReorderStickerData.fromJson(item)).toList(),
    );
  }
}

class ReorderStickerData {
  final String stickerId;
  final int seq;

  ReorderStickerData({
    required this.stickerId,
    required this.seq,
  });

  factory ReorderStickerData.fromJson(Map<String, dynamic> json) {
    return ReorderStickerData(
      stickerId: json['stickerId'],
      seq: json['seq'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stickerId': stickerId,
      'seq': seq,
    };
  }
}
