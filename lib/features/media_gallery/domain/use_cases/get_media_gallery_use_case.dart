import 'package:uchat/features/media_gallery/domain/model/media_gallery_result.dart';
import 'package:uchat/features/media_gallery/domain/params/media_gallery_params.dart';
import 'package:uchat/features/media_gallery/presentation/views/screens/media_gallery.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetMediaGalleryUseCase extends SimpleUseCase<MediaGalleryResult?, MediaGalleryParams> {
  @override
  Future<MediaGalleryResult?> call(MediaGalleryParams params) {
    return MediaGallery.open(
      filterMediaType: params.filterMediaType,
      maxSelectable: params.maxSelectable,
      showDragHandle: params.showDragHandle,
      doneButtonType: params.doneButtonType,
      appBarActionType: params.appBarActionType,
      onDoneCallback: params.onDoneCallback,
      enablePickingUnsupportedTypeOnAndroid: params.enablePickingUnsupportedTypeOnAndroid,
    );
  }
}
