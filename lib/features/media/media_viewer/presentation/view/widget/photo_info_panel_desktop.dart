import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/media/media_viewer/data/model/media_file_model.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/features/media/media_viewer/presentation/controller/media_viewer_controller.dart';
import 'package:uchat/features/media/media_viewer/presentation/view/widget/action_top_widget_desktop.dart';

class PhotoInfoPanelDesktop extends StatelessWidget {
  final bool show;
  final MediaFileModel media;
  final MediaViewerOpenFrom openFrom;
  final VoidCallback onClosePage;
  final VoidCallback onDownload;
  final VoidCallback onShare;
  final VoidCallback onGridPressed;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onMaximize;
  final VoidCallback onJumpToMessage;
  final bool isSecretRoom;

  const PhotoInfoPanelDesktop({
    super.key,
    required this.show,
    required this.media,
    required this.onClosePage,
    required this.onShare,
    required this.onGridPressed,
    required this.onDownload,
    this.isSecretRoom = false,
    required this.openFrom,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onMaximize,
    required this.onJumpToMessage,
  });

  MediaViewerController get mediaViewerCtl {
    return Get.find<MediaViewerController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Top menu
        ActionTopWidgetDesktop(
          show: show,
          media: media,
          openFrom: openFrom,
          onDownload: onDownload,
          onShare: onShare,
          onJumpToMessage: onJumpToMessage,
          onZoomIn: onZoomIn,
          onZoomOut: onZoomOut,
          onMaximize: onMaximize,
        ),
      ],
    );
  }
}
