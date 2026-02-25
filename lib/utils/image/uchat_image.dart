import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/utils/app_env.dart';

import 'uchat_network_image_provider.dart';

extension UChatImage on ExtendedImage {
  static HttpCaller httpCaller = HttpCaller();

  static ExtendedImage network(
    String url, {
    Key? key,
    String? animateTag,
    bool useUChatHeader = true,
    bool enableSlideOutPage = false,
    ExtendedImageMode mode = ExtendedImageMode.none,
    bool cache = true,
    bool clearMemoryCacheIfFailed = true,
    FilterQuality filterQuality = FilterQuality.low,
    BoxFit? fit,

    /// Optional - Function to build a custom loading widget or execute some code when image is loading
    /// Default widget is empty Container
    Widget Function(ExtendedImageState)? customLoadingWidget,

    /// Optional - Function to build a custom image widget or execute some code when image loading is completed
    /// Default widget is normal ExtendedImage
    Widget Function(ExtendedImageState)? customImageWidget,

    /// Optional - Function to build a custom error widget or execute some code when image loading has failed
    /// Default widget is error icon
    Widget Function(ExtendedImageState)? customErrorWidget,
    double? width,
    double? height,

    /// Network config
    double scale = 1.0,
    CancellationToken? cancelToken,
    int retries = 3,
    Duration? timeLimit,
    Duration timeRetry = const Duration(milliseconds: 100),
    String? cacheKey,
    bool cacheRawData = false,
    String? imageCacheName,
    Duration? cacheMaxAge,

    /// Image Resize config
    double? compressionRatio,
    int? maxBytes,
    int? cacheWidth,
    int? cacheHeight,
    Color? color,
    AlwaysStoppedAnimation<double>? opacity,
  }) {
    assert(url.isNotEmpty, 'UChatImage.network: url is empty');
    final image = ExtendedResizeImage.resizeIfNeeded(
      provider: UChatNetworkImageProvider(
        url,
        scale: scale,
        headers: useUChatHeader ? httpCaller.apiHeader : null,
        cache: cache,
        cancelToken: cancelToken,
        retries: retries,
        timeRetry: timeRetry,
        timeLimit: timeLimit,
        cacheKey: cacheKey,
        printError: AppEnv.isDebug,
        cacheRawData: cacheRawData,
        imageCacheName: imageCacheName,
        cacheMaxAge: cacheMaxAge,
      ),
      compressionRatio: compressionRatio,
      maxBytes: maxBytes,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      cacheRawData: cacheRawData,
      imageCacheName: imageCacheName,
    );

    Widget imageWithAnimated(ExtendedImageState state) {
      Widget widget = const SizedBox();
      String key = 'LoadState.loading';
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          key = 'LoadState.loading';
          if (customLoadingWidget != null) {
            widget = customLoadingWidget(state);
          } else {
            widget = Container();
          }
        case LoadState.completed:
          key = 'LoadState.completed';
          if (customImageWidget != null) {
            widget = customImageWidget(state);
          } else {
            widget = state.completedWidget;
          }
        case LoadState.failed:
          key = 'LoadState.failed';
          if (customErrorWidget != null) {
            widget = customErrorWidget(state);
          }
          widget = const Icon(Icons.error);
      }
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        child: SizedBox(
          key: ValueKey('$key-$animateTag'),
          child: widget,
        ),
      );
    }

    Widget imageWithoutAnimated(ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          if (customLoadingWidget != null) {
            return customLoadingWidget(state);
          }
          return Container();
        case LoadState.completed:
          if (customImageWidget != null) {
            return customImageWidget(state);
          }
          return state.completedWidget;
        case LoadState.failed:
          if (customErrorWidget != null) {
            return customErrorWidget(state);
          }
          return const Icon(Icons.error);
      }
    }

    return ExtendedImage(
      key: key,
      image: image,
      enableSlideOutPage: enableSlideOutPage,
      mode: mode,
      fit: fit,
      clearMemoryCacheIfFailed: clearMemoryCacheIfFailed,
      filterQuality: filterQuality,
      width: width,
      height: height,
      loadStateChanged: animateTag != null ? imageWithAnimated : imageWithoutAnimated,
      color: color,
      opacity: opacity,
    );
  }

  static UChatNetworkImageProvider networkProvider(
    String url, {
    String? cacheKey,
    double? scale,
    bool cache = true,
    CancellationToken? cancelToken,
    int retries = 3,
    Duration? timeLimit,
    Duration timeRetry = const Duration(milliseconds: 100),
    bool cacheRawData = false,
    String? imageCacheName,
    Duration? cacheMaxAge,
  }) {
    return UChatNetworkImageProvider(
      url,
      scale: scale ?? 1.0,
      headers: httpCaller.apiHeader,
      cache: cache,
      cancelToken: cancelToken,
      retries: retries,
      timeRetry: timeRetry,
      timeLimit: timeLimit,
      cacheKey: cacheKey,
      printError: AppEnv.isDebug,
      cacheRawData: cacheRawData,
      imageCacheName: imageCacheName,
      cacheMaxAge: cacheMaxAge,
    );
  }

  static ExtendedImage file(
    String path, {
    BoxFit? fit,

    /// Optional - Function to build a custom loading widget or execute some code when image is loading
    /// Default widget is empty Container
    Widget Function(ExtendedImageState)? customLoadingWidget,

    /// Optional - Function to build a custom image widget or execute some code when image loading is completed
    /// Default widget is normal ExtendedImage
    Widget Function(ExtendedImageState)? customImageWidget,

    /// Optional - Function to build a custom error widget or execute some code when image loading has failed
    /// Default widget is error icon
    Widget Function(ExtendedImageState)? customErrorWidget,
    double? width,
    double? height,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    File file = File(path);
    final image = ExtendedResizeImage.resizeIfNeeded(
      provider: ExtendedFileImageProvider(file),
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
    );
    return ExtendedImage(
      image: image,
      fit: fit,
      width: width,
      height: height,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            if (customLoadingWidget != null) {
              return customLoadingWidget(state);
            }
            return Container();
          case LoadState.completed:
            if (customImageWidget != null) {
              return customImageWidget(state);
            }
            return state.completedWidget;
          case LoadState.failed:
            if (customErrorWidget != null) {
              return customErrorWidget(state);
            }
            return const Icon(Icons.error);
        }
      },
    );
  }
}
