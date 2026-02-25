// import 'package:extended_image/extended_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_blurhash/flutter_blurhash.dart';
// import 'package:get/get_utils/src/extensions/context_extensions.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
// import 'package:uchat/core/extensions/theme_extensions.dart';
// import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
// import 'package:uchat/gen/assets.gen.dart';
// import 'package:uchat/utils/blurhash.dart';
// import 'package:uchat/utils/extension/extension.dart';
// import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';
//
// class ImageAssetEntityPreview extends StatefulWidget {
//   final MessageFileModel messageFileModel;
//   final double width;
//   final double height;
//   final Widget? fallBackWidget;
//
//   const ImageAssetEntityPreview({
//     super.key,
//     required this.messageFileModel,
//     required this.width,
//     required this.height,
//     this.fallBackWidget,
//   });
//
//   @override
//   State<ImageAssetEntityPreview> createState() => _ImageAssetEntityPreviewState();
// }
//
// class _ImageAssetEntityPreviewState extends State<ImageAssetEntityPreview> {
//   AssetEntity? asset;
//
//   @override
//   void initState() {
//     AssetEntity.fromId(widget.messageFileModel.assetId!).then((value) {
//       setState(() {
//         asset = value;
//       });
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.messageFileModel.assetId == null || asset == null) {
//       return widget.fallBackWidget ?? const SizedBox.shrink();
//     }
//
//     AssetEntityImageProvider imageProvider = AssetEntityImageProvider(
//       asset!,
//       isOriginal: false,
//       thumbnailSize: ThumbnailSize(widget.width.cacheSize, widget.height.cacheSize),
//     );
//     return ExtendedImage(
//       image: imageProvider,
//       fit: BoxFit.cover,
//       filterQuality: FilterQuality.low,
//       width: widget.width,
//       height: widget.height,
//       loadStateChanged: (state) {
//         switch (state.extendedImageLoadState) {
//           case LoadState.loading:
//             return widget.messageFileModel.blurhash?.isNotEmpty == true
//                 ? BlurHash(
//                     hash: blurhashDefault(widget.messageFileModel.blurhash),
//                     optimizationMode: BlurHashOptimizationMode.approximation,
//                   )
//                 : ShimmerLoading(
//                     enable: true,
//                     baseColor: context.theme.appColors.backgroundNeutralLight,
//                     highlightColor: context.theme.appColors.backgroundNeutralLightest,
//                     child: Container(
//                       color: Colors.blue.shade100,
//                       width: widget.width,
//                       height: widget.height,
//                     ),
//                   );
//           case LoadState.failed:
//             return widget.fallBackWidget ??
//                 Container(
//                   color: context.theme.appColors.backgroundNeutralLightPressed,
//                   child: Center(
//                     child: Assets.vectors.photoOutlined.svg(),
//                   ),
//                 );
//           case LoadState.completed:
//             return state.completedWidget;
//         }
//       },
//     );
//   }
// }

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/blurhash.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class ImageAssetEntityPreview extends StatefulWidget {
  final MessageFileModel messageFileModel;
  final double width;
  final double height;
  final Widget? fallBackWidget;

  const ImageAssetEntityPreview({
    super.key,
    required this.messageFileModel,
    required this.width,
    required this.height,
    this.fallBackWidget,
  });

  @override
  State<ImageAssetEntityPreview> createState() => _ImageAssetEntityPreviewState();
}

class _ImageAssetEntityPreviewState extends State<ImageAssetEntityPreview> {
  AssetEntity? asset;

  @override
  void initState() {
    super.initState();
    _loadAsset();
  }

  void _loadAsset() {
    AssetEntity.fromId(widget.messageFileModel.assetId!).then((value) {
      if (mounted) {
        setState(() {
          asset = value;
        });
      }
    }).catchError((error) {
      // Log error but don't crash the app
      debugPrint('Failed to load asset: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_shouldShowFallback()) {
      return widget.fallBackWidget ?? const SizedBox.shrink();
    }

    return _buildImage(context);
  }

  bool _shouldShowFallback() {
    return widget.messageFileModel.assetId == null || asset == null;
  }

  Widget _buildImage(BuildContext context) {
    final imageProvider = _createImageProvider();
    return ExtendedImage(
      image: imageProvider,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.low,
      width: widget.width,
      height: widget.height,
      loadStateChanged: (state) => _handleLoadState(context, state),
    );
  }

  AssetEntityImageProvider _createImageProvider() {
    return AssetEntityImageProvider(
      asset!,
      isOriginal: false,
      thumbnailSize: ThumbnailSize(widget.width.cacheSize, widget.height.cacheSize),
    );
  }

  Widget _handleLoadState(BuildContext context, ExtendedImageState state) {
    switch (state.extendedImageLoadState) {
      case LoadState.loading:
        return _buildLoadingState(context);
      case LoadState.failed:
        return _buildFailedState(context);
      case LoadState.completed:
        return state.completedWidget;
    }
  }

  Widget _buildLoadingState(BuildContext context) {
    return widget.messageFileModel.blurhash?.isNotEmpty == true
        ? BlurHash(
            hash: blurhashDefault(widget.messageFileModel.blurhash),
            optimizationMode: BlurHashOptimizationMode.approximation,
          )
        : ShimmerLoading(
            enable: true,
            baseColor: context.theme.appColors.backgroundNeutralLight,
            highlightColor: context.theme.appColors.backgroundNeutralLightest,
            child: Container(
              color: Colors.blue.shade100,
              width: widget.width,
              height: widget.height,
            ),
          );
  }

  Widget _buildFailedState(BuildContext context) {
    return widget.fallBackWidget ??
        Container(
          color: context.theme.appColors.backgroundNeutralLightPressed,
          child: Center(
            child: Assets.vectors.photoOutlined.svg(),
          ),
        );
  }
}
