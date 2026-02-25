import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/screens.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';

class SearchInput extends GetView<RoomsEditController> {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: StickyHeader(
        backgroundColor: Colors.transparent,
        size: 50,
        widget: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4),
          child: SearchBox(
            color: UTheme.color.scaffoldInput,
            focusNode: controller.searchInputFocus,
            searchController: controller.searchController,
            onSuffixPressed: controller.handleClearSearch,
          ),
        ),
      ),
    );
  }
}
