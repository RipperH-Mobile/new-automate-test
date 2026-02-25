import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/features/media_gallery/domain/model/media_gallery_result.dart';
import 'package:uchat/features/media_gallery/presentation/views/screens/media_gallery.dart';

class MediaGalleryParams {
  final bool showDragHandle;
  final int maxSelectable;
  final MediaGalleryDoneButtonType doneButtonType;
  final MediaGalleryAppBarActionType appBarActionType;
  final MediaGalleryFilterMediaType filterMediaType;
  final Future<void> Function(MediaGalleryResult result, {int loopCount})? onDoneCallback;

  /// Whether or not to enable picking unsupported type such as HEIC, HEIF, tiff, tif images on Android
  /// If true, HEIC, HEIF, tiff, tif images will be allowed to be picked on Android devices.
  /// otherwise, they can't be picked and show an unsupported file dialog.
  final bool enablePickingUnsupportedTypeOnAndroid;

  MediaGalleryParams({
    this.showDragHandle = true,
    this.maxSelectable = UChatConstant.maxSelectableMediaFromGallery,
    this.doneButtonType = MediaGalleryDoneButtonType.done,
    this.appBarActionType = MediaGalleryAppBarActionType.close,
    this.filterMediaType = MediaGalleryFilterMediaType.imageAndVideo,
    this.onDoneCallback,
    this.enablePickingUnsupportedTypeOnAndroid = true,
  });
}
