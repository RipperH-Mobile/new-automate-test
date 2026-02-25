// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sliding_up_panel2/sliding_up_panel2.dart';
// import 'package:uchat/controllers/permission_controller.dart';
// import 'package:uchat/screens/map/map_controller.dart';
// import 'package:uchat/widgets.dart';
// import 'package:uchat/widgets/map/map.dart';
// import 'package:uchat/widgets/map/message_box.dart';

// const mapPinPath = 'assets/images/map_pin_icon.png';

// class MapScreen extends GetView<MapController> {
//   const MapScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final sc = ScrollController();

//     return PopScope(
//       canPop: false,
//       child: Scaffold(
//         appBar: appBarMap(),
//         backgroundColor: Colors.grey,
//         body: SlidingUpPanel(
//           onPanelSlide: controller.onPanelPositionChange,
//           onPanelOpened: controller.onPanelOpened,
//           onPanelClosed: controller.onPanelClosed,
//           controller: controller.panelController,
//           maxHeight: controller.maxPanelHeight,
//           minHeight: controller.minPanelHeight,
//           scrollController: sc,
//           parallaxEnabled: true,
//           parallaxOffset: .5,
//           body: mapWidget(),
//           header: searchHeader(),
//           panelBuilder: () {
//             return searchResultListViewContainer(sc);
//           },
//         ),
//       ),
//     );
//   }

//   PreferredSizeWidget appBarMap() {
//     return AppBar(
//       title: Text(
//         'Location share'.tr,
//         style: const TextStyle(color: Colors.black),
//       ),
//       backgroundColor: Colors.white,
//       elevation: 0,
//       actions: [
//         Obx(() {
//           if (controller.isFullScreen.value && controller.isHasFocus.value) {
//             return IconButton(
//               onPressed: controller.onPressedCloseFullScreenSearchMap,
//               icon: const Icon(
//                 Icons.close,
//                 color: Colors.black,
//               ),
//             );
//           } else {
//             return Obx(() {
//               return TextButton(
//                 onPressed: controller.hasLocationPermission.value
//                     ? controller.onPressedDone
//                     : () async {
//                         PermissionController permissionController = PermissionController.instance;
//                         bool granted = await permissionController.checkLocationPermission();
//                         if (granted) {
//                           controller.hasLocationPermission.value = true;
//                           controller.onPressedDone();
//                         }
//                       },
//                 child: Text(
//                   'Done'.tr,
//                   style: TextStyle(
//                     color: controller.selectedLocation() != null ? Colors.blue : Colors.grey,
//                   ),
//                 ),
//               );
//             });
//           }
//         })
//       ],
//       automaticallyImplyLeading: false,
//       leading: Obx(() {
//         if (controller.isFullScreen.value && controller.isHasFocus.value) {
//           return const SizedBox.shrink();
//         }

//         return IconButton(
//           onPressed: controller.onPressedLeadingBack,
//           icon: const Icon(
//             Icons.arrow_back_ios_new,
//             color: Colors.black,
//           ),
//         );
//       }),
//     );
//   }

//   Widget mapWidget() {
//     return Stack(
//       alignment: AlignmentDirectional.center,
//       children: [
//         Obx(() {
//           return MapWidget(
//             mapPadding: controller.mapScrollPadding,
//             markers: controller.markers.values.toSet(),
//             initCameraPosition: controller.cameraPosition()!,
//             onMapCreate: controller.onMapCreate,
//             onMapTap: controller.onMapTaped,
//             onCameraMove: controller.onMapMoved,
//             mapId: controller.waitForMapId,
//             onCameraIdle: controller.onMapMovedEnd,
//             onCameraMoveStarted: () {},
//           );
//         }),
//         Align(
//           alignment: Alignment.topLeft,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: FloatingActionButton(
//               onPressed: () async {
//                 await controller.moveToCurrentLocation();
//               },
//               elevation: 0,
//               mini: true,
//               child: const Icon(Icons.location_searching),
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.topCenter,
//           child: Obx(() {
//             final items = <Widget>[];

//             if (controller.isLoading()) {
//               items.add(
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 126.0),
//                   child: MessageBox(
//                     isLoading: true,
//                     title: 'Searching...'.tr,
//                     subtitle: '',
//                   ),
//                 ),
//               );
//             } else if (controller.selectedLocation() != null) {
//               items.add(
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 126.0),
//                   child: MessageBox(
//                     title: controller.selectedTitle,
//                     subtitle: controller.selectedSubtitle,
//                   ),
//                 ),
//               );
//             }

//             items.add(
//               Padding(
//                 padding: const EdgeInsets.only(left: 0.0),
//                 child: Image.asset(mapPinPath, width: 48),
//               ),
//             );

//             return SizedBox(
//               height: controller.mapHeight,
//               child: SizedBox(
//                 height: 50,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 70.0),
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: items,
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }

//   Widget searchHeader() {
//     return SizedBox(
//       width: Get.width,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Obx(() {
//             bool showNod = controller.isFullScreen.value && controller.isHasFocus.value;
//             return AnimatedSwitcher(
//               duration: const Duration(milliseconds: 300),
//               child: showNod
//                   ? const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         height: 5,
//                       ),
//                     )
//                   : Container(
//                       height: 5,
//                       width: 50,
//                       margin: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade300,
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                     ),
//             );
//           }),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 15.0,
//               vertical: 6,
//             ),
//             child: SearchBox(
//               label: 'Search location'.tr,
//               searchController: controller.searchController,
//               focusNode: controller.focus,
//               onChanged: controller.onSearchChanged,
//               onSuffixPressed: () {
//                 controller.searchController.clear();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget searchResultListViewContainer(ScrollController sc) {
//     return AnimatedSwitcher(
//       duration: const Duration(milliseconds: 300),
//       child: Obx(() {
//         if (controller.isPanelClose.value) {
//           return const SizedBox.shrink();
//         }

//         return LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//             double maxHeight = constraints.maxHeight;

//             return Padding(
//               padding: EdgeInsets.only(top: Get.height * .135 - 30),
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: maxHeight,
//                   maxHeight: maxHeight,
//                 ),
//                 child: searchResultListView(sc),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }

//   Widget searchResultListView(ScrollController sc) {
//     return Obx(() {
//       if (controller.isSearchLoading()) {
//         return const Center(child: CircularProgressIndicator());
//       }

//       if (controller.nearBySearchMaps.isEmpty) {
//         return Center(
//           child: Text('No search result'.tr),
//         );
//       }

//       return ListView.builder(
//         controller: sc,
//         padding: const EdgeInsets.only(bottom: 50),
//         itemCount: controller.nearBySearchMaps.length,
//         itemBuilder: (context, i) {
//           final searchResult = controller.nearBySearchMaps[i];
//           final title = searchResult.name ?? '';
//           final subtitle = searchResult.locationFormattedAddress ?? searchResult.vicinity ?? '';

//           return Material(
//             child: InkWell(
//               onTap: () async {
//                 await controller.onSearchResultTaped(searchResult);
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border(
//                     bottom: BorderSide(
//                       color: Colors.grey.withValues(alpha: .2),
//                       width: 0.5,
//                     ),
//                   ),
//                 ),
//                 child: ListTile(
//                   title: Text(title),
//                   subtitle: Text(
//                     subtitle,
//                     maxLines: 1,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }
// }
