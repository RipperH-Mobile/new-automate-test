import 'package:uchat/features/media_gallery/domain/model/media_gallery_result.dart';
import 'package:uchat/features/media_gallery/presentation/views/screens/media_gallery.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetOneImageGalleryUseCase extends SimpleUseCase<MediaGalleryResult?, NoParams> {
  @override
  Future<MediaGalleryResult?> call(NoParams params) async {
    return await MediaGallery.open(
      filterMediaType: MediaGalleryFilterMediaType.image,
      maxSelectable: 1,
    );
  }
}
