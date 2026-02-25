import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_group_owner_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_all_member_and_admin_request.dart';
import 'package:uchat/features/chat_room_detail/domain/params/get_one_member_params.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/change_group_owner_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_all_member_and_admin_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_one_member_use_case.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_owner_transfer_argument.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ChatRoomDetailOwnerTransferIds {
  ChatRoomDetailOwnerTransferIds._();

  static const String memberList = 'memberList';
}

class ChatRoomDetailOwnerTransferController extends GetxController {
  final ChatRoomDetailOwnerTransferArgument args;
  final GetOneMemberUseCase getCurrentMemberUseCase;

  ChatRoomDetailOwnerTransferController({
    required this.args,
    required this.getCurrentMemberUseCase,
  });

  List<RoomMemberEntity> members = [];
  int currentPage = 1;
  String searchText = '';
  final currentUserMemberData = Rx<RoomMemberEntity?>(null);
  bool initializing = true;
  final searchInputFocus = FocusNode();
  final searchController = TextEditingController();
  final title = ''.obs;
  final isShowLeaveGroup = false.obs;

  @override
  void onInit() async {
    await initAdminList();
    title.value = args.roomName;
    isShowLeaveGroup.value = args.isShowLeaveGroup;
    getCurrentUserMemberData();
    initializing = false;

    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    searchInputFocus.dispose();
    super.onClose();
  }

  Future<void> initAdminList() async {
    members = await GetIt.I<GetAllMemberAndAdminUseCase>().call(
      GetAllMemberAndAdminRequest(
        roomId: args.roomId,
        page: 1,
      ),
    );

    currentPage = 1;

    update([ChatRoomDetailOwnerTransferIds.memberList]);
  }

  void onSearchTextChanged(String text) async {
    searchText = text;

    final membersEntity = await GetIt.I<GetAllMemberAndAdminUseCase>().call(
      GetAllMemberAndAdminRequest(
        keyword: text,
        roomId: args.roomId,
        page: 1,
      ),
    );
    currentPage = 1;
    members = membersEntity;
    update([ChatRoomDetailOwnerTransferIds.memberList]);
  }

  void getCurrentUserMemberData() async {
    final accountId = UserController.instance.currentUser()?.id;
    if (accountId == null) return;
    try {
      final memberData = await getCurrentMemberUseCase.call(GetOneMemberParams(
        roomId: args.roomId,
        accountId: accountId,
      ));
      currentUserMemberData(memberData);
    } catch (e, stackTrace) {
      _log.e('getCurrentUserMemberData error.', e, stackTrace);
    }
  }

  void handleOwnerTransfer(RoomMemberEntity member) async {
    try {
      await GetIt.I<ChangeGroupOwnerUseCase>().call(
        ChangeGroupOwnerRequest(
          roomId: args.roomId,
          newOwnerId: member.account.id ?? '',
        ),
      );
      if (isShowLeaveGroup.value) {
        Get.back(result: true);
      } else {
        Get.close(2);
      }
    } catch (e, stackTrace) {
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
      useLogger().e('handleAddAdmin error.', e, stackTrace);
    }
  }
}
