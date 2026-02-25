// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:uchat/themes/themes.dart';
// import 'package:uchat/widgets.dart';

// import '../select_member_controller.dart';

// class SearchInput extends GetView<SelectMemberController> {
//   const SearchInput({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         top: 11.spMin,
//         left: 20.spMin,
//         right: 20.spMin,
//       ),
//       child: Container(
//         height: 38.spMin,
//         decoration: ShapeDecoration(
//           color: UTheme.color.searchBarFilledColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//         ),
//         child: SearchBox(
//           color: UTheme.color.searchBarFilledColor,
//           focusNode: controller.searchInputFocus,
//           searchController: controller.searchController,
//           onSuffixPressed: controller.handleClearSearch,
//           onChanged: (String value) {},
//         ),
//       ),
//     );
//   }
// }
