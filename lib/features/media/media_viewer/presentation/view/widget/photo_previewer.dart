import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/features/media/media_viewer/presentation/view/widget/hero_widget.dart';
import 'package:uchat/utils/image/uchat_image.dart';

class PhotoPreviewer extends StatelessWidget {
  final String heroTag;
  final String mediaUrl;
  final String? thumbnailUrl;
  final File? decryptedFile;
  final GlobalKey<ExtendedImageSlidePageState> slidePagekey;

  const PhotoPreviewer({
    super.key,
    required this.heroTag,
    required this.slidePagekey,
    required this.mediaUrl,
    this.thumbnailUrl,
    this.decryptedFile,
  });

  @override
  Widget build(BuildContext context) {
    return HeroWidget(
      tag: heroTag,
      slidePagekey: slidePagekey,
      slideType: SlideType.onlyImage,
      child: _Image(
        thumbnailUrl: thumbnailUrl,
        mediaUrl: mediaUrl,
        decryptedFile: decryptedFile,
      ),
    );
  }
}

class _Image extends StatefulWidget {
  const _Image({required this.thumbnailUrl, required this.mediaUrl, this.decryptedFile});

  final String? thumbnailUrl;
  final String mediaUrl;
  final File? decryptedFile;

  @override
  State<_Image> createState() => _ImageState();
}

class _ImageState extends State<_Image> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  void Function()? _animationListener;
  List<double> doubleTapScales = <double>[1.0, 2.0];

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    if (_animationListener != null) {
      _animation?.removeListener(_animationListener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late ImageProvider<Object> imageProvider;
    if (widget.decryptedFile != null) {
      imageProvider = FileImage(widget.decryptedFile!);
    } else if (widget.thumbnailUrl != null && widget.thumbnailUrl?.isNotEmpty == true) {
      imageProvider = FileImage(File(widget.thumbnailUrl!));
    } else {
      imageProvider = UChatImage.networkProvider(widget.mediaUrl);
    }

    return ExtendedImage(
      image: ExtendedResizeImage.resizeIfNeeded(
        provider: imageProvider,
      ),
      enableSlideOutPage: true,
      fit: BoxFit.contain,
      mode: ExtendedImageMode.gesture,
      initGestureConfigHandler: (ExtendedImageState state) {
        return GestureConfig(
          //you must set inPageView true if you want to use ExtendedImageGesturePageView
          inPageView: true,
          initialScale: 1.0,
          minScale: 1.0,
          maxScale: 5.0,
          animationMaxScale: 6.0,
          initialAlignment: InitialAlignment.center,
        );
      },
      clearMemoryCacheIfFailed: true,
      clearMemoryCacheWhenDispose: false,
      // Fix something blinking

      loadStateChanged: (state) {
        if (state.extendedImageLoadState == LoadState.failed) {
          return Center(
            child: Icon(
              Icons.error,
              color: Colors.white,
              size: 40.spMin,
            ),
          );
        }
        return null;
      },
      onDoubleTap: (ExtendedImageGestureState state) {
        ///you can use define pointerDownPosition as you can,
        ///default value is double tap pointer down postion.
        var pointerDownPosition = state.pointerDownPosition;
        double begin = state.gestureDetails?.totalScale ?? 0;
        double end;

        if (_animationListener != null) {
          _animation?.removeListener(_animationListener!);
        }

        //stop pre
        _animationController?.stop();

        //reset to use
        _animationController?.reset();

        if (begin == doubleTapScales[0]) {
          end = doubleTapScales[1];
        } else {
          end = doubleTapScales[0];
        }

        _animation = _animationController?.drive(Tween<double>(begin: begin, end: end));

        _animationListener = () {
          state.handleDoubleTap(scale: _animation?.value, doubleTapPosition: pointerDownPosition);
        };

        _animation?.addListener(_animationListener!);

        _animationController?.forward().whenComplete(() {
          _animation?.removeListener(_animationListener!);
        });
      },
    );
  }
}
