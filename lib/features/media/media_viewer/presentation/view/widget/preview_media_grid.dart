import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'package:uchat/features/media/media_viewer/data/model/media_file_model.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/features/media/media_viewer/presentation/view/widget/image_widget.dart';
import 'package:uchat/widgets/animation/transition/bottom_transition.dart';

class PreviewMediaGrid extends StatelessWidget {
  final GlobalKey<ExtendedImageSlidePageState> slidePagekey;
  final ScrollController scrollController;
  final bool show;
  final List<MediaFileModel> medias;
  final Function(int) onTap;
  final int currentMediaIndex;
  final ListController listController;
  final MediaViewerOpenFrom openFrom;
  final bool reverse;

  const PreviewMediaGrid({
    super.key,
    required this.slidePagekey,
    required this.scrollController,
    required this.show,
    required this.medias,
    required this.onTap,
    required this.currentMediaIndex,
    required this.listController,
    required this.openFrom,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: fromBottomTransitionBuilder,
      duration: const Duration(milliseconds: 200),
      child: show
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70.spMin,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: .75),
                  // color: Colors.transparent,
                ),
                child: SuperListView.builder(
                  reverse: reverse,
                  scrollDirection: Axis.horizontal,
                  controller: scrollController,
                  listController: listController,
                  itemCount: medias.length,
                  itemBuilder: (context, index) {
                    final media = medias[index];
                    bool isCurrentIndexShowing = currentMediaIndex == index;

                    return GestureDetector(
                      onTap: () {
                        // controller.onTapMediaItem(index);
                        onTap(index);
                      },
                      child: Container(
                        height: 50.spMin,
                        width: 50.spMin,
                        margin: EdgeInsets.only(left: 2.spMin, right: 2.spMin, bottom: 10.spMin, top: 10.spMin),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.spMin),
                        ),
                        child: ImageWidget(roomFile: media, isCurrentIndexShowing: isCurrentIndexShowing),
                        // ),
                      ),
                    );
                  },
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
