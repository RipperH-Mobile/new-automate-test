import 'package:isar_community/isar.dart';

part 'official_menu_container_model.g.dart';

@embedded
class OfficialMenuContainerModel {
  // Possibility of aspect ratio
  static const ratioSixtyNine = '16:9';
  static const ratioFourThree = '4:3';

  String? aspectRatio;
  double? width;
  double? height;
  String? imageFileId;

  OfficialMenuContainerModel({
    this.aspectRatio,
    this.width,
    this.height,
    this.imageFileId,
  });

  factory OfficialMenuContainerModel.fromMap(Map<String, dynamic> data) {
    var container = OfficialMenuContainerModel();

    if (data['width'] is int) {
      container.width = (data['width'] as int).toDouble();
    } else if (data['width'] is double) {
      container.width = data['width'] as double;
    }

    if (data['height'] is int) {
      container.height = (data['height'] as int).toDouble();
    } else if (data['height'] is double) {
      container.height = data['height'] as double;
    }

    container.imageFileId = data['imageFileId'] as String?;
    container.aspectRatio = data['aspectRatio'] as String;

    return container;
  }

  double get widthRatio {
    if (aspectRatio == OfficialMenuContainerModel.ratioFourThree) {
      return 4 / 3;
    } else if (aspectRatio == OfficialMenuContainerModel.ratioSixtyNine) {
      return 16 / 9;
    }

    return 0.0;
  }

  double get heightRatio {
    if (aspectRatio == OfficialMenuContainerModel.ratioFourThree) {
      return 3 / 4;
    } else if (aspectRatio == OfficialMenuContainerModel.ratioSixtyNine) {
      return 9 / 16;
    }

    return 0.0;
  }

  @override
  String toString() {
    return 'AspectRatio: $aspectRatio, ImageFileId: $imageFileId';
  }

  Map<String, dynamic> toMap() {
    return {
      'aspectRatio': aspectRatio,
      'width': width,
      'height': height,
      'imageFileId': imageFileId,
    };
  }
}
