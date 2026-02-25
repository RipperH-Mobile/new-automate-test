import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/input/search_box.dart';

class RoomDetailSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final FocusNode searchInputFocus;
  final Function(String) onChanged;

  const RoomDetailSearchBar({
    super.key,
    required this.searchController,
    required this.searchInputFocus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpace.space4,
      ),
      child: Container(
        height: AppSize.size10,
        decoration: ShapeDecoration(
          color: context.theme.appColors.backgroundNeutralLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.roundedXl),
          ),
        ),
        child: SearchBox(
          color: context.theme.appColors.backgroundNeutralLight,
          searchController: searchController,
          focusNode: searchInputFocus,
          onChanged: onChanged,
          label: 'Search'.tr,
        ),
      ),
    );
  }
}
