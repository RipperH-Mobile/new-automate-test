// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:uchat/entities/collections.dart';
// import 'package:uchat/entities/interfaces.dart';
// import 'package:uchat/widgets.dart';

// import '../select_member_controller.dart';

// class SearchedContacts extends GetView<SelectMemberController> {
//   const SearchedContacts({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Padding(
//         padding: EdgeInsets.symmetric(horizontal: 8.spMin),
//         child: ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: controller.contacts.length,
//           itemBuilder: (BuildContext context, int index) {
//             ContactCollection currentContact = controller.contacts.elementAt(index);

//             return Obx(() {
//               return ContactListItemSelectable<ContactInterface>(
//                 showStatusMessage: false,
//                 data: currentContact,
//                 isChecked: controller.selectedContacts.any((element) => element.id == currentContact.id),
//                 onPressed: () {
//                   controller.handleSelectCheckbox(currentContact);
//                   // controller.handleSelectCheckboxForAddToFolder(currentContact);
//                 },
//               );
//             });
//           },
//         ),
//       );
//     });
//   }
// }
