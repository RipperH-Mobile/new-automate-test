import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/features/media/media_viewer/data/model/media_file_model.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/utils/extension/extension.dart';

class ActionTopWidgetDesktop extends StatelessWidget {
  final bool show;
  final MediaFileModel media;
  final MediaViewerOpenFrom openFrom;
  final VoidCallback? onDownload;
  final VoidCallback? onShare;
  final VoidCallback? onJumpToMessage;
  final VoidCallback? onZoomOut;
  final VoidCallback? onZoomIn;
  final VoidCallback? onMaximize;
  final bool disableActionDivider;

  const ActionTopWidgetDesktop({
    super.key,
    required this.show,
    required this.media,
    required this.openFrom,
    this.onDownload,
    this.onShare,
    this.onJumpToMessage,
    this.onZoomOut,
    this.onZoomIn,
    this.onMaximize,
    this.disableActionDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return topAction();
  }

  Widget topAction() {
    return Align(
      alignment: Alignment.topCenter,
      child: AnimatedOpacity(
        opacity: show ? 1 : 0,
        duration: const Duration(milliseconds: 100),
        child: GestureDetector(
          // Add this gesture detector to prevent closing info panel when tapping on empty space of header bar
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.5),
                  Colors.black.withValues(alpha: 0.15),
                  Colors.black.withValues(alpha: 0.0),
                ],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.spMin,
                  vertical: 10.spMin,
                ),
                child: SizedBox(
                  height: 55.spMin,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                          onTap: onJumpToMessage,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                media.sentByName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.spMin,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    media.sentAtStringDesktop,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: .75),
                                      fontSize: 12.spMin,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 3.spMin),
                                  Image.asset(
                                    UChatAssetPath.nextMediaDesktop,
                                    height: 12.spMin,
                                    width: 12.spMin,
                                    cacheWidth: 50.cacheSize,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              child: Container(
                                width: 20.spMin,
                                height: 20.spMin,
                                padding: EdgeInsets.all(6.spMin),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFcccccc),
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  UChatAssetPath.crossIcon,
                                  height: 5.spMin,
                                  width: 5.spMin,
                                  cacheWidth: 50.cacheSize,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                Get.back<bool>(result: false);
                              },
                            ),
                            5.horizontalSpace,
                            Visibility(
                              visible: disableActionDivider == false,
                              child: SizedBox(
                                height: 18.spMin,
                                child: VerticalDivider(
                                  color: Colors.white.withValues(alpha: .5),
                                  width: 1.spMin,
                                  thickness: 1.spMin,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12.spMin,
                            ),
                            Visibility(
                              visible: onZoomOut != null,
                              child: InkWell(
                                onTap: onZoomOut,
                                child: Image.asset(
                                  UChatAssetPath.zoomOutMediaDesktop,
                                  height: 24.spMin,
                                  width: 24.spMin,
                                  cacheWidth: 50.cacheSize,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.spMin,
                            ),
                            Visibility(
                              visible: onZoomIn != null,
                              child: InkWell(
                                onTap: onZoomIn,
                                child: Image.asset(
                                  UChatAssetPath.zoomInMediaDesktop,
                                  height: 24.spMin,
                                  width: 24.spMin,
                                  cacheWidth: 50.cacheSize,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.spMin,
                            ),
                            Visibility(
                              visible: onMaximize != null,
                              child: InkWell(
                                onTap: onMaximize,
                                child: Image.asset(
                                  UChatAssetPath.maximizeMediaDesktop,
                                  height: 24.spMin,
                                  width: 24.spMin,
                                  cacheWidth: 50.cacheSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!(openFrom == MediaViewerOpenFrom.profileAvatar))
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Visibility(
                                visible: onDownload != null,
                                child: InkWell(
                                  onTap: onDownload,
                                  child: Image.asset(
                                    UChatAssetPath.downloadMediaDesktop,
                                    width: 24.spMin,
                                    cacheWidth: 50.cacheSize,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.spMin),
                              Visibility(
                                visible: onShare != null,
                                child: InkWell(
                                  onTap: onShare,
                                  child: Image.asset(
                                    UChatAssetPath.shareMediaDesktop,
                                    width: 24.spMin,
                                    cacheWidth: 50.cacheSize,
                                  ),
                                ),
                              ),
                              // SizedBox(width: 8.spMin),
                              // NOTE: Bookmark feature is not implemented yet
                              // InkWell(
                              //   onTap: () {},
                              //   child: Image.asset(
                              //     UChatAssetPath.bookmarkMediaDesktop,
                              //     width: 24.spMin,
                              //     cacheWidth: 50.cacheSize,
                              //   ),
                              // ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
