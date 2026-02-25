import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room_detail/data/models/models/room_waiting_list_model.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_promotable_members_request.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_promotable_members_use_case.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_admin_add_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_admin_add_select_argument.dart';
import 'package:uchat/routes/app_pages.dart';

class ChatRoomDetailAdminAddSelectIds {
  ChatRoomDetailAdminAddSelectIds._();

  static const String memberList = 'memberList';
}

class ChatRoomDetailAdminAddSelectController extends GetxController {
  final ChatRoomDetailAdminAddSelectArgument args;
  final GetPromotableMemberUseCase getPromotableMemberUseCase;

  final scrollController = ScrollController();
  final searchInputFocus = FocusNode();
  final searchController = TextEditingController();

  StreamSubscription? addMemberSub;
  StreamSubscription? removeMemberSub;
  StreamSubscription? updateMemberSub;

  String searchText = '';
  List<RoomDetailMemberAndPendingModel> members = [];
  bool initializing = true;
  int currentPage = 1;

  ChatRoomDetailAdminAddSelectController({
    required this.args,
    required this.getPromotableMemberUseCase,
  });

  @override
  void onInit() async {
    await initMemberList();
    scrollController.addListener(onScroll);
    initUpdateListener();
    initializing = false;

    super.onInit();
  }

  @override
  void onClose() {
    addMemberSub?.cancel();
    removeMemberSub?.cancel();
    updateMemberSub?.cancel();
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    searchController.dispose();
    searchInputFocus.dispose();
    super.onClose();
  }

  Future<void> initMemberList() async {
    final membersEntity = await getPromotableMemberUseCase.call(GetPromotableMembersRequest(
      roomId: args.roomId,
      page: 1,
    ));
    currentPage = 1;
    members = membersEntity.map((e) => RoomDetailMemberAndPendingModel.fromRoomMemberEntity(e)).toList();

    update([ChatRoomDetailAdminAddSelectIds.memberList]);
  }

  void onScroll() {
    // Get the scroll direction of the scroll view
    final scrollDirection = scrollController.position.userScrollDirection;
    // If the scroll direction is forward, that means the user is scrolling down then return
    if (scrollDirection == ScrollDirection.forward) {
      return;
    }

    // Maximum scroll extent of the scroll view
    final maxScrollPixel = scrollController.position.maxScrollExtent;
    final shouldLoadAtPixel = maxScrollPixel * 0.8;
    // Current scroll position of the scroll view
    final pixels = scrollController.position.pixels;

    // Check if the user is at the top of the list
    final isAtTop = pixels >= shouldLoadAtPixel;
    if (isAtTop) {
      EasyThrottle.throttle(
        'get_more_promotable_members',
        const Duration(milliseconds: 500),
        () async {
          final membersEntity = await getPromotableMemberUseCase.call(GetPromotableMembersRequest(
            keyword: searchText,
            roomId: args.roomId,
            page: currentPage + 1,
          ));
          currentPage += 1;
          members.addAll(
            membersEntity.map((e) => RoomDetailMemberAndPendingModel.fromRoomMemberEntity(e)),
          );
          update([ChatRoomDetailAdminAddSelectIds.memberList]);
        },
      );
    }
  }

  void initUpdateListener() {
    addMemberSub = eventBus.on<AddRoomMemberEvent>().listen((event) {
      if (event.roomId == args.roomId) {
        for (final memberCollection in event.member) {
          final memberEntity = memberCollection.toEntity();
          final newMember = RoomDetailMemberAndPendingModel.fromRoomMemberEntity(memberEntity);
          members.add(newMember);
        }
        update([ChatRoomDetailAdminAddSelectIds.memberList]);
      }
    });

    removeMemberSub = eventBus.on<RemoveRoomMemberEvent>().listen((event) {
      if (event.roomId == args.roomId) {
        for (final accountId in event.memberIds) {
          members.removeWhere((member) => member.accountId == accountId);
        }
        update([ChatRoomDetailAdminAddSelectIds.memberList]);
      }
    });

    updateMemberSub = eventBus.on<UpdateRoomMemberEvent>().listen((event) {
      if (event.roomId == args.roomId) {
        for (final memberCollection in event.members) {
          final index = members.indexWhere((member) => member.accountId == memberCollection.accountId);
          if (index != -1) {
            members[index] = RoomDetailMemberAndPendingModel.fromRoomMemberEntity(memberCollection.toEntity());
          }
        }
        update([ChatRoomDetailAdminAddSelectIds.memberList]);
      }
    });
  }

  void handleMemberPressed(RoomDetailMemberAndPendingModel member, BuildContext context) {
    Get.toNamed(
      Routes.roomDetailAdminAdd.replaceAll(':id', args.roomId),
      arguments: ChatRoomDetailAdminAddArgument(
        roomId: args.roomId,
        member: member,
      ),
    );
  }

  void onSearchTextChanged(String text) async {
    searchText = text;
    final membersEntity = await getPromotableMemberUseCase.call(GetPromotableMembersRequest(
      keyword: text,
      roomId: args.roomId,
      page: 1,
    ));
    currentPage = 1;
    members = membersEntity.map((e) => RoomDetailMemberAndPendingModel.fromRoomMemberEntity(e)).toList();

    update([ChatRoomDetailAdminAddSelectIds.memberList]);
  }
}
