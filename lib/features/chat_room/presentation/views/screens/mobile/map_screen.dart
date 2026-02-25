import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uchat/api/payloads/map/map_info.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/presentation/widgets/snapping_panel.dart';
import 'package:uchat/features/chat_room/presentation/controllers/map_controller.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/map/map.dart';
import 'package:uchat/widgets/map/message_box.dart';

const mapPinPath = 'assets/images/map_pin_icon.png';

class MapScreen extends GetView<MapController> {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Scaffold(
            appBar: _buildAppBar(context),
            backgroundColor: context.theme.appColors.backgroundNeutralLightest,
            body: mapWidget(),
          ),
          Obx(
            () => AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.vertical,
                  child: child,
                );
              },
              child: controller.isFullScreen.value
                  ? Container(
                      key: const ValueKey('fullScreen'),
                      color: context.theme.appColors.borderDisable,
                    )
                  : Container(
                      key: const ValueKey('notFullScreen'),
                      height: 0,
                    ),
            ),
          ),
          SafeArea(
            child: SnappingBottomSheet(
              isFull: (isFull) {
                controller.isFullScreen.value = isFull;
              },
              focusNode: controller.focus,
              header: searchHeader(context),
              contentBuilder: (child, ctl) => searchResultListView(context, ScrollController(), ctl),
              floatButton: controller.isFullScreen.value ? null : _buildMyLocation(context),
            ),
          ),
        ],
      ),
    );
  }

  AppBarDefault _buildAppBar(BuildContext context) {
    return AppBarDefault(
      title: 'Locations'.tr,
      leadingButton: AppControlButton.back(
        context: context,
      ),
      actionButton: AppControlButton.forward(
        context: context,
        label: 'Share'.tr,
        onTap: () {
          controller.onPressedShareLocations();
        },
        actionColor: context.theme.appColors.textPrimary,
      ),
      automaticallyImplyLeading: false,
    );
  }

  Widget mapWidget() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Obx(() {
          return MapWidget(
            mapPadding: controller.mapScrollPadding,
            markers: controller.markers.values.toSet(),
            initCameraPosition: controller.cameraPosition()!,
            onMapCreate: controller.onMapCreate,
            onMapTap: controller.onMapTaped,
            onCameraMove: controller.onMapMoved,
            mapId: controller.waitForMapId,
            onCameraIdle: controller.onMapMovedEnd,
            onCameraMoveStarted: () {},
          );
        }),
        Align(
          alignment: Alignment.topCenter,
          child: Obx(() {
            final items = <Widget>[];

            if (controller.isLoading()) {
              items.add(
                Padding(
                  padding: EdgeInsets.only(bottom: 240.spMin),
                  child: MessageBox(
                    isLoading: true,
                    title: 'Searching...'.tr,
                  ),
                ),
              );
            } else if (controller.selectedLocation() != null) {
              items.add(
                Padding(
                  padding: EdgeInsets.only(bottom: 240.spMin),
                  child: MessageBox(
                    title: controller.selectedTitle,
                  ),
                ),
              );
            }

            items.add(
              Padding(
                padding: EdgeInsets.only(left: 0.0, bottom: 155.spMin),
                child: Image.asset(
                  'assets/images/v2/location.png',
                  width: 30.spMin,
                  height: 36.spMin,
                ),
              ),
            );

            return SizedBox(
              height: controller.mapHeight,
              child: SizedBox(
                height: 50.spMin,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70.spMin),
                  child: Stack(
                    alignment: Alignment.center,
                    children: items,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget searchHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpace.space4,
        vertical: AppSpace.space2,
      ),
      child: Container(
        height: AppSize.size10,
        decoration: ShapeDecoration(
          color: context.theme.appColors.backgroundNeutralLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.roundedXl),
          ),
        ),
        child: Obx(
          () => SearchBox(
            color: context.theme.appColors.backgroundNeutralLight,
            searchController: controller.searchController,
            label: 'Search'.tr,
            focusNode: controller.focus,
            onChanged: controller.onSearchChanged,
            hasSuffix: controller.searchText.value.isNotEmpty,
            onSuffixPressed: () {
              controller.handleClearSearch();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMyLocation(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await controller.moveToCurrentLocation();
      },
      child: Container(
        width: 40.spMin,
        height: 40.spMin,
        padding: const EdgeInsets.all(
          AppSize.size1,
        ),
        decoration: ShapeDecoration(
          color: context.theme.appColors.iconPrimaryInverse.withValues(alpha: 0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.roundedFull),
          ),
          shadows: [
            BoxShadow(
              color: const Color(0x1E000000),
              blurRadius: 4.spMin,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.spMin,
              height: 20.spMin,
              child: Image.asset(
                'assets/images/v2/navigate_to_my_location.png',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchResultListView(
      BuildContext context, ScrollController sc, DraggableScrollableController? draggableController) {
    return Obx(() {
      if (controller.isSearchLoading()) {
        return buildShimmerLoading(context, sc);
      }

      if (controller.nearBySearchMaps.isEmpty) {
        return _buildNotFound(context);
      }

      return ListView.separated(
        controller: sc,
        padding: EdgeInsets.only(bottom: 50.spMin),
        itemCount: controller.nearBySearchMaps.length + 1,
        itemBuilder: (context, index) {
          // If index == length, return final divider
          if (index == controller.nearBySearchMaps.length) {
            return Padding(
              padding: const EdgeInsets.only(left: AppSpace.space4),
              child: Divider(
                thickness: AppSize.sizePx,
                height: 0,
                color: context.theme.appColors.borderDisable,
              ),
            );
          }
          final searchResult = controller.nearBySearchMaps[index];
          final title = searchResult.name ?? '';
          final subtitle = searchResult.locationFormattedAddress ?? searchResult.vicinity ?? '';

          return _buildResultTile(context, title, subtitle, searchResult, draggableController);
        },
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: AppSpace.space4),
          child: Divider(
            thickness: AppSize.sizePx,
            height: 0,
            color: context.theme.appColors.borderDisable,
          ),
        ),
      );
    });
  }

  Widget _buildResultTile(BuildContext context, String title, String subTitle, MapInfoResponse searchResult,
      DraggableScrollableController? draggableController) {
    return Obx(
      () => Material(
        child: InkWell(
          onTap: () async {
            draggableController?.animateTo(
              0.5,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            await controller.onSearchResultTaped(searchResult);
          },
          child: Container(
            decoration: BoxDecoration(
              color: context.theme.appColors.backgroundNeutralLightest,
            ),
            child: ListTile(
              dense: true,
              visualDensity: VisualDensity(vertical: -2.spMin),
              title: RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: _highlightText(title, controller.searchText.value, context),
              ),
              subtitle: AppText.body4(
                subTitle,
                context: context,
                color: context.theme.appColors.textLight,
                maxLines: 1,
              ),
              trailing: (controller.selectedLocation.value != null) &&
                      (controller.selectedLocation.value?.name == searchResult.name)
                  ? Image.asset(
                      'assets/images/v2/new_check_icon.png',
                      width: AppSize.size6,
                      height: AppSize.size6,
                      color: context.theme.appColors.iconPrimary,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  TextSpan _highlightText(String source, String query, BuildContext context) {
    final TextStyle defaultStyle = Theme.of(context).appTexts.body3Bold.copyWith(
          color: context.theme.appColors.textDarkest,
        );
    final TextStyle highlightStyle = defaultStyle.copyWith(
      color: context.theme.appColors.textPrimary,
    );

    if (query.isEmpty) {
      return TextSpan(text: source, style: defaultStyle);
    }

    final List<TextSpan> spans = [];
    final String sourceLC = source.toLowerCase();
    final String queryLC = query.toLowerCase();
    int start = 0;

    int index = sourceLC.indexOf(queryLC, start);
    while (index != -1) {
      // Add text before the match.
      if (index > start) {
        spans.add(TextSpan(text: source.substring(start, index), style: defaultStyle));
      }
      // Add the matched text.
      spans.add(
        TextSpan(text: source.substring(index, index + query.length), style: highlightStyle),
      );
      start = index + query.length;
      index = sourceLC.indexOf(queryLC, start);
    }
    // Add the rest of the string.
    if (start < source.length) {
      spans.add(TextSpan(text: source.substring(start), style: defaultStyle));
    }
    return TextSpan(children: spans, style: defaultStyle);
  }

  Widget _buildNotFound(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Prevents the Column from expanding to fill the available space.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText.body2Bold(
              'No results found'.tr,
              context: context,
              color: context.theme.appColors.textDark,
            ),
            const SizedBox(height: AppSpace.space2),
            AppText.body4(
              'Please try searching again with different \nkeywords or check your spelling'.tr,
              context: context,
              color: context.theme.appColors.textLight,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: kToolbarHeight * 1.5),
          ],
        ),
      ),
    );
  }

  Widget buildShimmerLoading(BuildContext context, ScrollController sc) {
    return ListView.separated(
      controller: sc,
      padding: EdgeInsets.only(bottom: 50.spMin),
      itemCount: 10,
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: AppSpace.space4),
        child: Divider(
          thickness: AppSize.sizePx,
          height: AppSize.sizePx,
          color: context.theme.appColors.borderDisable,
        ),
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.space4,
              vertical: AppSpace.space4,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Mimic the title and subtitle texts
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: AppSpace.space4,
                        width: 100.spMin,
                        color: context.theme.appColors.textPrimaryInverse,
                      ),
                      const SizedBox(
                        height: AppSpace.space2,
                      ),
                      Container(
                        height: 14.spMin,
                        width: double.infinity,
                        color: context.theme.appColors.textPrimaryInverse,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
