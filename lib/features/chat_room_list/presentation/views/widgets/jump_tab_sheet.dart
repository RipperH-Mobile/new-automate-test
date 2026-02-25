import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room_list/presentation/controllers/chat_list_controller.dart';

class JumpTabSheet extends StatelessWidget {
  const JumpTabSheet({super.key});

  ChatListController get roomCtl => ChatListController.instance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 45, 20, 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Folder'.tr,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel'.tr,
                    style: const TextStyle(
                      color: Color(0xff0057FF),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: roomCtl.chatFolderController.chatFolders.length,
          //     itemBuilder: (context, index) {
          //       return GestureDetector(
          //         onTap: () {
          //           roomCtl.chatFolderController.tabController.index = index;
          //           Navigator.pop(context);
          //         },
          //         child: Container(
          //           color: Colors.transparent,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               if (index == 0)
          //                 const Divider(
          //                   height: 1,
          //                   thickness: 1,
          //                   color: Color(0xffE6E6E6),
          //                 ),
          //               Padding(
          //                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text(
          //                       roomCtl.chatFolderController.chatFolders[index].displayName,
          //                       style: TextStyle(
          //                         color: index == roomCtl.chatFolderController.tabController.index
          //                             ? const Color(0xff0057FF)
          //                             : const Color(0xff333333),
          //                         fontSize: 16,
          //                         fontWeight: index == roomCtl.chatFolderController.tabController.index
          //                             ? FontWeight.w600
          //                             : FontWeight.w400,
          //                       ),
          //                     ),
          //                     if (index == roomCtl.chatFolderController.tabController.index)
          //                       const SizedBox(
          //                         width: 20,
          //                         height: 20,
          //                         child: Image(
          //                           image: AssetImage(
          //                             'assets/images/downloaded.png',
          //                           ),
          //                         ),
          //                       ),
          //                   ],
          //                 ),
          //               ),
          //               const Divider(
          //                 height: 1,
          //                 thickness: 1,
          //                 color: Color(0xffE6E6E6),
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
