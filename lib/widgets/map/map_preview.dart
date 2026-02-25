import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/api/payloads/map/map_info.dart';
import 'package:uchat/api/services/google_place_service.dart';
import 'package:uchat/utils/uchat_image.dart';

import 'map_preview_fullscreen.dart';

class MapPreview extends StatefulWidget {
  final MapInfoResponse mapInfo;

  const MapPreview({
    super.key,
    required this.mapInfo,
  });

  @override
  State<MapPreview> createState() => MapPreviewState();
}

class MapPreviewState extends State<MapPreview> {
  bool isLatitudeValid(double? value) {
    if (value == null) return false;
    return value.isFinite && (value.abs() <= 90);
  }

  bool isLongitudeValid(double? value) {
    if (value == null) return false;
    return value.isFinite && (value.abs() <= 180);
  }

  bool isMapParamsReadyForOpenMap() {
    return widget.mapInfo.location != null &&
        widget.mapInfo.location?.latitude != null &&
        widget.mapInfo.location?.longitude != null &&
        isLatitudeValid(widget.mapInfo.location?.latitude) &&
        isLongitudeValid(widget.mapInfo.location?.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return openContainerAnimation();
  }

  Widget openContainerAnimation() {
    return OpenContainer<dynamic>(
      transitionDuration: const Duration(milliseconds: 300),
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      openBuilder: (_, closeContainer) {
        return MapPreviewFullScreen(mapInfo: widget.mapInfo);
      },
      onClosed: (res) {},
      tappable: false,
      closedElevation: 0,
      closedBuilder: (_, openContainer) {
        return previewWidget(openContainer);
      },
    );
  }

  Widget previewWidget(Function openContainer) {
    return SizedBox(
      width: 200.spMin,
      height: 240.spMin,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return GestureDetector(
            onTapUp: (_) {
              if (isMapParamsReadyForOpenMap()) {
                openContainer();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  topRight: Radius.circular(15.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _mapPreviewTitleHeader(constraints.maxWidth),
                  Expanded(
                    child: _mapPreviewBody(constraints.maxWidth),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _mapPreviewTitleHeader(width) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: width,
            child: Text(
              widget.mapInfo.name ?? 'Unable to get name'.tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: widget.mapInfo.name == null ? Colors.grey : Colors.black,
              ),
            ),
          ),
          (widget.mapInfo.locationFormattedAddress != null || widget.mapInfo.vicinity != null)
              ? Text(
                  widget.mapInfo.locationFormattedAddress ?? widget.mapInfo.vicinity!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: widget.mapInfo.name == null ? Colors.grey : Colors.black.withValues(alpha: 0.6),
                    height: 1.1,
                    fontWeight: FontWeight.w300,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _mapPreviewBody(width) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        SizedBox(
          width: width,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15.r),
              bottomLeft: Radius.circular(15.r),
            ),
            child: _buildLocationImage(),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.map_sharp,
                ),
                Text('Map'.tr)
              ],
            ),
          ),
        )
      ],
    );
  }

  _buildLocationImage() {
    final locationImgBlurhash = widget.mapInfo.locationImgBlurhash;
    final location = widget.mapInfo.location;

    if (locationImgBlurhash == null && location != null) {
      return UChatImage.network(
        GooglePlaceService().staticMapApi(
          widget.mapInfo.location!,
        ),
        cache: true,
        clearMemoryCacheIfFailed: false,
        filterQuality: FilterQuality.medium,
        fit: BoxFit.cover,
      );
    }

    final locationImgId = widget.mapInfo.locationImgId;
    if (locationImgId == null && locationImgBlurhash != null) {
      return BlurHash(hash: locationImgBlurhash);
    }

    if (widget.mapInfo.mapPreview == null) {
      return Container(
        color: Colors.grey.withValues(alpha: 0.3),
        child: const Icon(Icons.warning),
      );
    }
    return UChatImage.network(
      widget.mapInfo.mapPreview!,
      fit: BoxFit.cover,
      customErrorWidget: (state) {
        return Container(
          color: Colors.grey.withValues(alpha: 0.3),
          child: const Icon(Icons.warning),
        );
      },
    );
  }
}
