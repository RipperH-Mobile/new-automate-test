import 'package:get/get.dart';

enum StickerStoreTabCategory {
  home('Home'),
  popular('Popular'),
  recommended('Recommended'),
  free('Free');

  final String value;

  const StickerStoreTabCategory(this.value);

  String get translatedValue {
    switch (this) {
      case home:
        return 'Stickers'.tr;
      case popular:
        return 'Popular'.tr;
      case recommended:
        return 'Recommended'.tr;
      case free:
        return 'Free'.tr;
    }
  }

  static List<StickerStoreTabCategory> get excludeHomeCategory => StickerStoreTabCategory.values
      .where(
        (category) => category != StickerStoreTabCategory.home,
      )
      .toList();

  String get serverKey {
    switch (this) {
      case home:
        return 'All';
      case popular:
        return 'POPULAR';
      case recommended:
        return 'RECOMMENDED';
      case free:
        return 'FREE';
    }
  }
}
