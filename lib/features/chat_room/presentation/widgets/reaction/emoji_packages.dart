import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uchat/constants/uchat_dimensions.dart';
import 'package:uchat/features/chat_room/domain/entities/emoji_package_entity.dart';
import 'package:uchat/features/chat_room/presentation/controllers/reaction/customize_reaction_controller.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/uchat_image.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class EmojiPackages extends GetView<CustomizeReactionController> {
  const EmojiPackages({super.key});

  static final itemSpace = 28.spMin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.spMin,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFF2F2F2),
            width: 1,
          ),
        ),
      ),
      child: PagedListView(
        pagingController: controller.packagesPagingController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: UChatDimensions.emojiCustomizeItemSpace,
        ),
        builderDelegate: PagedChildBuilderDelegate<EmojiPackageEntity>(
          itemBuilder: (context, item, index) {
            if (item.coverImageUrl != null) {
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  controller.selectPackage(item);
                },
                child: Container(
                  margin: EdgeInsets.only(right: itemSpace),
                  height: itemSpace,
                  width: itemSpace,
                  child: Obx(
                    () => UChatImage.network(
                      item.coverImageUrl!,
                      color: controller.currentEmojiPackage.value?.id == item.id ? UTheme.color.primary : null,
                      customLoadingWidget: (p0) {
                        return const _ShimmerItem();
                      },
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
          firstPageProgressIndicatorBuilder: (context) => _buildShimmerPackages(),
          newPageProgressIndicatorBuilder: (context) => const _ShimmerItem(),
        ),
      ),
    );
  }

  Widget _buildShimmerPackages() {
    return Row(
      children: List.generate(
        10,
        (index) => Padding(
          padding: EdgeInsets.only(right: itemSpace),
          child: const _ShimmerItem(),
        ),
      ),
    );
  }
}

class _ShimmerItem extends StatelessWidget {
  const _ShimmerItem();

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      enable: true,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        height: 24.spMin,
        width: 24.spMin,
      ),
    );
  }
}
