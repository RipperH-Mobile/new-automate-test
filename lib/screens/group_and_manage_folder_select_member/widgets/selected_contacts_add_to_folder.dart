// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:uchat/screens/group_and_manage_folder_select_member/widgets/contact_item.dart';

// import '../select_member_controller.dart';

// class SelectedContactsAddToFolder extends GetView<SelectMemberController> {
//   const SelectedContactsAddToFolder({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final selectedLength = controller.selectedGroupsAndContacts.length;

//       return AnimatedContainer(
//         height: selectedLength > 0 ? 100.spMin : 0,
//         curve: Curves.easeOutQuad,
//         duration: const Duration(milliseconds: 200),
//         child: _buildSelectedList(context),
//         onEnd: () {
//           if (selectedLength > 0) {
//             controller.isShowSelectedList(true);
//           } else {
//             controller.isShowSelectedList(false);
//           }
//         },
//       );
//     });
//   }

//   Widget _buildSelectedList(BuildContext context) {
//     final selectedLength = controller.selectedGroupsAndContacts.length;

//     return Obx(() {
//       return Visibility(
//         visible: controller.isShowSelectedList(),
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(
//             15.spMin,
//             12.spMin,
//             15.spMin,
//             6.spMin,
//           ),
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: selectedLength,
//             itemBuilder: (BuildContext context, int index) {
//               double pr = (selectedLength - 1) > index ? 12 : 0;
//               final contact = controller.selectedGroupsAndContacts.elementAt(index);

//               return FadeInRight(
//                 child: Padding(
//                   padding: EdgeInsets.only(right: pr.spMin),
//                   child: ContactItem(
//                     key: Key('contact-${contact.id}'),
//                     avatarUrl: contact.avatarUrl!,
//                     hasAvatar: contact.hasAvatar,
//                     title: contact.name!,
//                     contactId: contact.id!,
//                     onDeleteMember: () {
//                       controller.handleSelectCheckboxForAddToFolder(contact);
//                     },
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       );
//     });
//   }
// }
