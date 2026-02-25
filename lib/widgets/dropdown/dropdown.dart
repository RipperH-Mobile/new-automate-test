// import 'package:flutter/material.dart';
// import 'package:get/utils.dart';
//
// enum AlbumSortType { Latest, Oldest }
//
// const List<String> list = <String>['ใหม่สุด', 'เก่าสุด'];
//
// class DropdownButtonApp extends StatelessWidget {
//   const DropdownButtonApp({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('DropdownButton Sample')),
//         body: const Center(
//           child: DropdownButtonExample(),
//         ),
//       ),
//     );
//   }
// }
//
// class DropdownButtonExample extends StatefulWidget {
//   final void Function(AlbumSortType)? onSelectChanged;
//   const DropdownButtonExample({super.key, this.onSelectChanged});
//
//   @override
//   State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
// }
//
// class _DropdownButtonExampleState extends State<DropdownButtonExample> {
//   AlbumSortType dropdownValue = AlbumSortType.Latest;
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<AlbumSortType>(
//       value: dropdownValue,
//       underline: const SizedBox.shrink(),
//       icon: const Icon(Icons.arrow_drop_down_rounded),
//       elevation: 16,
//       style: const TextStyle(color: Colors.deepPurple),
//       isExpanded: true,
//       onChanged: (AlbumSortType? value) {
//         // This is called when the user selects an item.
//         setState(() {
//           dropdownValue = value!;
//           widget.onSelectChanged?.call(dropdownValue);
//         });
//       },
//       items: AlbumSortType.values.toList().map<DropdownMenuItem<AlbumSortType>>((AlbumSortType value) {
//         return DropdownMenuItem<AlbumSortType>(
//           value: value,
//           child: Text(value.name.tr),
//         );
//       }).toList(),
//     );
//   }
// }
