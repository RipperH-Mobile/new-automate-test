// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import '../select_member_controller.dart';

// class SearchedContactsLabel extends GetView<SelectMemberController> {
//   final bool isAllContacts;
//   const SearchedContactsLabel({
//     super.key,
//     required this.isAllContacts,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final selectedLength = controller.selectedContacts.length;
//       return Align(
//         alignment: Alignment.centerLeft,
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: 20.spMin,
//             vertical: 10.spMin,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               RichText(
//                 text: TextSpan(
//                   text: isAllContacts ? '${'Contacts'.tr} ' : 'Recent Chats'.tr,
//                   style: DefaultTextStyle.of(context).style.copyWith(
//                         color: const Color(0xFF333333),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: isAllContacts ? controller.contacts.length.toString() : '',
//                       style: TextStyle(
//                         color: const Color(0xFF999999),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               isAllContacts
//                   ? Container()
//                   : RichText(
//                       text: selectedLength != 0
//                           ? TextSpan(
//                               text: 'Selected @count'.trParams({
//                                 'count': selectedLength.toString(),
//                               }),
//                               style: DefaultTextStyle.of(context).style.copyWith(
//                                     color: const Color(0xFF1A1A1A),
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                             )
//                           : TextSpan(
//                               text: 'Select'.tr,
//                               style: DefaultTextStyle.of(context).style.copyWith(
//                                     color: const Color(0xFF999999),
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                             ),
//                     ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
