// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:uchat/widgets/avatar/avatar.dart';

// class ContactItem extends StatefulWidget {
//   final String title;
//   final String contactId;
//   final String avatarUrl;
//   // hasAvatar is unused in this widget but keep it for now just in case ?
//   final bool hasAvatar;
//   final String? avatarText;
//   final Function? onDeleteMember;
//   final bool showDeleteButton;

//   const ContactItem({
//     super.key,
//     required this.title,
//     required this.contactId,
//     required this.avatarUrl,
//     required this.hasAvatar,
//     this.avatarText,
//     this.onDeleteMember,
//     this.showDeleteButton = true,
//   });

//   @override
//   ContactItemState createState() => ContactItemState();
// }

// class ContactItemState extends State<ContactItem> {
//   bool isSelected = false;

//   ContactItemState() : super();

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SizedBox(
//           width: 60.spMin,
//           child: Column(
//             children: <Widget>[
//               Avatar(
//                 radius: 28.spMin,
//                 avatarText: widget.avatarText,
//                 url: widget.avatarUrl,
//               ),
//               SizedBox(width: 16.spMin),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       widget.title,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (widget.showDeleteButton)
//           Positioned(
//             top: 0,
//             right: 0,
//             child: GestureDetector(
//               behavior: HitTestBehavior.translucent,
//               onTap: () {
//                 if (widget.onDeleteMember != null) widget.onDeleteMember!();
//               },
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   left: 15.spMin,
//                   bottom: 15.spMin,
//                 ),
//                 child: Container(
//                   height: 20.spMin,
//                   width: 20.spMin,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color(0xFFFF1552),
//                   ),
//                   child: Icon(
//                     Icons.close,
//                     size: 16.spMin,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
