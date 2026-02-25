// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:uchat/screens/group_and_manage_folder_select_member/widgets/searched_contacts.dart';
// import 'package:uchat/screens/group_and_manage_folder_select_member/widgets/selected_contacts_add_to_folder.dart';
// import 'package:uchat/screens/group_and_manage_folder_select_member/widgets/tab_directs.dart';
// import 'package:uchat/screens/group_and_manage_folder_select_member/widgets/tab_groups.dart';
// import 'package:uchat/features/chat_room_list/presentation/views/screens/mobile/create%20group/group_create_final_controller.dart';
// import 'package:uchat/features/chat_room_list/presentation/views/screens/mobile/create%20group/group_create_final_screen.dart';
// import 'package:uchat/themes/util.dart';
// import 'package:uchat/utils/responsive/responsive_screen_util.dart';
// import 'package:uchat/widgets.dart';
// import 'package:uchat/widgets/animation/transition/right_transition.dart';
// import 'package:uchat/widgets/app/app_bar_close_button.dart';

// import 'select_member_controller.dart';
// import 'widgets/last_chat_contacts.dart';
// import 'widgets/search_input.dart';
// import 'widgets/searched_contacts_label.dart';
// import 'widgets/selected_contacts.dart';

// class SelectMemberScreen extends GetView<SelectMemberController> {
//   const SelectMemberScreen({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (!UChatScreenUtil.instance.isMobile) {
//       return _buildCreateGroupDesktopUI(context);
//     }
//     return ScaffoldBasic(
//       appBar: AppBarWithCallHeader<PreferredSizeWidget>(
//         title: controller.isManageFolder() == true
//             ? AppBarTitle(
//                 title: 'Add Chats'.tr,
//               )
//             : AppBarTitle(
//                 title: 'Create Group'.tr,
//               ),
//         actions: controller.isManageFolder() == true ? [_buildManageFolderAction()] : [_buildAction()],
//         leading: AppBarBackButton(
//           onPressed: () => controller.handleBack(),
//         ),
//       ),
//       backgroundColor: Colors.white,
//       // child: _buildBody(context),
//       child: controller.isManageFolder() == true ? _buildBodyManageFolder(context) : _buildBody(context),
//     );
//   }

//   Widget _buildAction() {
//     return Padding(
//       padding: EdgeInsets.only(right: 20.spMin),
//       child: Center(
//         child: Obx(
//           () => GestureDetector(
//             onTap: controller.selectedContacts.isEmpty
//                 ? null
//                 : () {
//                     controller.handleCreateGroup();
//                   },
//             child: Text(
//               'Next'.tr,
//               textAlign: TextAlign.right,
//               style: TextStyle(
//                 color: controller.selectedContacts.isEmpty ? Colors.grey : UTheme.color.primary,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildManageFolderAction() {
//     return Padding(
//       padding: EdgeInsets.only(right: 20.spMin),
//       child: Center(
//         child: Obx(
//           () => GestureDetector(
//             onTap: controller.selectedGroupsAndContacts.isEmpty
//                 ? null
//                 : () {
//                     controller.handleManageFolderAddChatDone();
//                   },
//             child: Text(
//               'Done'.tr,
//               textAlign: TextAlign.right,
//               style: TextStyle(
//                 color: controller.selectedGroupsAndContacts.isEmpty ? Colors.grey : UTheme.color.primary,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBody(BuildContext context) {
//     return Column(
//       children: [
//         const SearchInput(),
//         const SelectedContacts(),
//         Expanded(
//           // using ListView instead of SingleChildScrollView is shacking on desktop dialog.
//           child: ListView.builder(
//             itemCount: 1,
//             itemBuilder: (c, index) {
//               return Column(
//                 children: [
//                   Obx(() {
//                     if (controller.searchText.value.isEmpty) {
//                       return const Column(
//                         children: [
//                           SearchedContactsLabel(
//                             isAllContacts: false,
//                           ),
//                           LastChatContacts(),
//                         ],
//                       );
//                     } else {
//                       return const SizedBox.shrink();
//                     }
//                   }),
//                   const SearchedContactsLabel(
//                     isAllContacts: true,
//                   ),
//                   const SearchedContacts(),
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCreateGroupDesktopUI(context) {
//     return ScaffoldBasic(
//       appBar: AppBarWithCallHeader<PreferredSizeWidget>(
//         centerTitle: true,
//         title: AppBarTitle(title: controller.isManageFolder() == true ? 'Add Chats'.tr : 'Create Group'.tr),
//         actions: controller.isManageFolder() == true
//             ? [_buildManageFolderAction()]
//             : [
//                 AppBarCloseButton(
//                   onPressed: () => controller.handleBack(),
//                   roundedBg: true,
//                 )
//               ],
//       ),
//       backgroundColor: Colors.white,
//       child: controller.isManageFolder() == true
//           ? _buildBodyManageFolder(context)
//           : Obx(
//               () {
//                 return Column(
//                   children: [
//                     Expanded(
//                       child: AnimatedSwitcher(
//                         transitionBuilder: fromRightTransitionBuilder,
//                         duration: const Duration(milliseconds: 300),
//                         child: controller.isLastPage()
//                             ? GetBuilder(
//                                 init: GroupCreateFinalController(),
//                                 builder: (ctl) {
//                                   return const GroupCreateFinalScreen();
//                                 },
//                               )
//                             : _buildBody(Get.context!),
//                       ),
//                     ),
//                     const Divider(
//                       height: 2,
//                       thickness: 2,
//                     ),
//                     InkWell(
//                       hoverColor: UTheme.color.primary.withValues(alpha: 0.2),
//                       onTap: () {
//                         if (controller.isLastPage()) {
//                           final createGroupFinalCtl = Get.find<GroupCreateFinalController>();
//                           createGroupFinalCtl.handleCreateGroupToServer();
//                         } else {
//                           controller.isLastPage(true);
//                         }
//                       },
//                       child: SizedBox(
//                         width: Get.width,
//                         child: Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Text(
//                               controller.isLastPage() ? 'Create'.tr : 'Next'.tr,
//                               style: TextStyle(
//                                 color: UTheme.color.primary,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//     );
//   }

//   Widget _buildBodyManageFolder(BuildContext context) {
//     return Column(
//       children: [
//         const SearchInput(),
//         SizedBox(
//           height: 20.spMin,
//         ),
//         const SelectedContactsAddToFolder(),
//         Obx(() {
//           return Expanded(
//             // using ListView instead of SingleChildScrollView is shacking on desktop dialog.
//             child: controller.groups.isEmpty && controller.contacts.isEmpty
//                 ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Contact not found'.tr,
//                         ),
//                         Text(
//                           'The user you were looking for was not found, \nplease check the user again.'.tr,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: Color(0xff999999),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: 1,
//                     itemBuilder: (c, index) {
//                       return Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('Group'.tr),
//                                 Row(
//                                   children: [
//                                     Text('Select'.tr),
//                                     Obx(() {
//                                       return controller.selectedGroupsAndContacts.isNotEmpty
//                                           ? Text(' ${controller.selectedGroupsAndContacts.length}')
//                                           : const Text('');
//                                     }),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const TabGroups(),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('Contacts'.tr),
//                                 const SizedBox(),
//                               ],
//                             ),
//                           ),
//                           const TabDirects(),
//                         ],
//                       );
//                     },
//                   ),
//           );
//         }),
//       ],
//     );
//   }
// }
