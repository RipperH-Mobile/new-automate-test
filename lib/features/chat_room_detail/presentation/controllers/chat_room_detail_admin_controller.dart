import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/event_bus/events/assign_admin_event.dart';
import 'package:uchat/core/event_bus/events/revoke_admin_event.dart';
import 'package:uchat/core/event_bus/events/update_admin_permission_event.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_all_admin_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/remove_group_admin_request.dart';
import 'package:uchat/features/chat_room_detail/domain/params/get_one_member_params.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_all_admin_and_owner_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_one_member_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/remove_group_admin_use_case.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_admin_add_select_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_admin_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_admin_edit_argument.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ChatRoomDetailAdminIds {
  ChatRoomDetailAdminIds._();

  static const String memberList = 'memberList';
}

class ChatRoomDetailAdminController extends GetxController {
  final ChatRoomDetailAdminArgument args;
  final GetAllAdminAndOwnerUseCase getAllAdminAndOwnerUseCase;
  final RemoveGroupAdminUseCase removeGroupAdminUseCase;
  final GetOneMemberUseCase getCurrentMemberUseCase;

  final scrollController = ScrollController();
  final searchInputFocus = FocusNode();
  final searchController = TextEditingController();

  StreamSubscription? addAdminSub;
  StreamSubscription? removeAdminSub;
  StreamSubscription? updateAdminSub;
  StreamSubscription? removeMemberSub;
  StreamSubscription? updateMemberSub;

  String searchText = '';
  List<RoomMemberEntity> members = [];
  bool initializing = true;
  int currentPage = 1;
  final currentUserMemberData = Rx<RoomMemberEntity?>(null);

  ChatRoomDetailAdminController({
    required this.args,
    required this.getAllAdminAndOwnerUseCase,
    required this.removeGroupAdminUseCase,
    required this.getCurrentMemberUseCase,
  });

  @override
  void onInit() async {
    await initAdminList();
    scrollController.addListener(onScroll);
    initUpdateListener();
    await getCurrentUserMemberData();
    initializing = false;
    update([ChatRoomDetailAdminIds.memberList]);

    super.onInit();
  }

  @override
  void onClose() {
    addAdminSub?.cancel();
    removeAdminSub?.cancel();
    updateAdminSub?.cancel();
    removeMemberSub?.cancel();
    updateMemberSub?.cancel();
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    searchController.dispose();
    searchInputFocus.dispose();
    super.onClose();
  }

  Future<void> initAdminList() async {
    members = await getAllAdminAndOwnerUseCase.call(GetAllAdminRequest(
      roomId: args.roomId,
      page: 1,
    ));

    currentPage = 1;

    update([ChatRoomDetailAdminIds.memberList]);
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
        'get_more_admin',
        const Duration(milliseconds: 500),
        () async {
          final membersEntity = await getAllAdminAndOwnerUseCase.call(GetAllAdminRequest(
            keyword: searchText,
            roomId: args.roomId,
            page: currentPage + 1,
          ));
          currentPage += 1;
          members.addAll(membersEntity);
          update([ChatRoomDetailAdminIds.memberList]);
        },
      );
    }
  }

  void initUpdateListener() {
    addAdminSub = eventBus.on<AssignAdminEvent>().listen((event) {
      if (event.roomId == args.roomId) {
        final memberCollection = event.member;

        final member = members.firstWhereOrNull((member) => member.account.id == memberCollection.accountId);

        if (member == null) {
          final memberEntity = event.member.toEntity();

          members.add(memberEntity);

          update([ChatRoomDetailAdminIds.memberList]);
        }
      }
    });

    removeAdminSub = eventBus.on<RevokeAdminEvent>().listen((event) {
      if (event.roomId == args.roomId) {
        final memberCollection = event.member;
        members.removeWhere((member) => member.account.id == memberCollection.accountId);
        update([ChatRoomDetailAdminIds.memberList]);
      }
    });

    updateAdminSub = eventBus.on<UpdateAdminPermissionEvent>().listen((event) {
      if (event.roomId == args.roomId) {
        final memberCollection = event.member;
        final index = members.indexWhere((member) => member.account.id == memberCollection.accountId);
        if (index != -1) {
          members[index] = memberCollection.toEntity();
        }
        update([ChatRoomDetailAdminIds.memberList]);
      }
    });

    removeMemberSub = eventBus.on<RemoveRoomMemberEvent>().listen((event) {
      if (event.roomId == args.roomId) {
        for (final accountId in event.memberIds) {
          members.removeWhere((member) => member.account.id == accountId);
        }
        update([ChatRoomDetailAdminIds.memberList]);
      }
    });

    updateMemberSub = eventBus.on<UpdateRoomMemberEvent>().listen((event) {
      if (event.roomId == args.roomId) {
        for (final memberCollection in event.members) {
          final index = members.indexWhere((member) => member.account.id == memberCollection.accountId);
          if (index != -1) {
            members[index] = memberCollection.toEntity();
          }
        }
        update([ChatRoomDetailAdminIds.memberList]);
      }
    });
  }

  void handleAddButtonPressed() {
    Get.toNamed(
      Routes.roomDetailAdminAddSelect.replaceAll(':id', args.roomId),
      arguments: ChatRoomDetailAdminAddSelectArgument(
        roomId: args.roomId,
      ),
    );
  }

  void handleEditAdmin(RoomMemberEntity member) {
    if (member.isOwner) return;
    Get.toNamed(
      Routes.roomDetailAdminEdit.replaceAll(':id', args.roomId),
      arguments: ChatRoomDetailAdminEditArgument(
        roomId: args.roomId,
        member: member,
      ),
    );
  }

  void onSearchTextChanged(String text) async {
    searchText = text;
    final membersEntity = await getAllAdminAndOwnerUseCase.call(GetAllAdminRequest(
      keyword: text.toLowerCase(),
      roomId: args.roomId,
      page: 1,
    ));
    currentPage = 1;
    members = membersEntity;
    update([ChatRoomDetailAdminIds.memberList]);
  }

  void handleRemoveAdmin(
    BuildContext context, {
    required RoomMemberEntity member,
  }) async {
    UChatNewDialog.showDialog(
      context: context,
      title: 'Remove ‘@name’ from administrators?'.trParams({
        'name': member.account.name ?? 'Unknown',
      }),
      description: 'This user will no longer be able to manage users, settings, or perform administrative tasks.'.tr,
      confirmText: 'Remove'.tr,
      confirmTextColor: context.theme.appColors.textError,
      onConfirm: () async {
        try {
          await removeGroupAdminUseCase.call(
            RemoveGroupAdminRequest(
              roomId: args.roomId,
              accountId: member.account.id ?? '',
            ),
          );
        } on FailedHostLookupException catch (_) {
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } on ApiException catch (e, stackTrace) {
          if (e.type == 'ERR_ACCOUNT_NOT_MEMBER_OR_ALREADY_HAS_ROLE') {
            UChatNewDialog.showGeneralErrorDialog(
              context: Get.context!,
              message: 'This user is not member of this room'.tr,
            );
          } else if (e.type == 'ERR_PERMISSION_DENIED') {
            UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
          } else {
            UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
            useLogger().e('Remove admin ApiException.', e, stackTrace);
          }
        } catch (e, stackTrace) {
          UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: ExceptionHandler.handle(e));
          useLogger().e('Remove admin error.', e, stackTrace);
        }
      },
    );
  }

  Future<void> getCurrentUserMemberData() async {
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
}
