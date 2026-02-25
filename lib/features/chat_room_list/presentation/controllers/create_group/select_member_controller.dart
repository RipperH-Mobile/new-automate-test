import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/room_contact_type.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/models/room_data_model.dart';
import 'package:uchat/features/chat_folder/domain/entities/chat_folder_entity.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_member_local_repository.dart';
import 'package:uchat/features/chat_room_detail/data/models/models/room_waiting_list_model.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/add_member_to_chat_request.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/add_member_to_chat_use_case.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_member_controller.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_sub_local_repository.dart';
import 'package:uchat/features/chat_room_list/presentation/arguments/select_member_arguments.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/domain/params/contact_params.dart';
import 'package:uchat/features/contact/domain/use_cases/get_can_chat_with_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/search_can_chat_with_contact_use_case.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SelectMemberController extends GetxController {
  final roomLocalRepository = GetIt.I<RoomLocalRepository>();
  final roomMemberLocalRepository = GetIt.I<RoomMemberLocalRepository>();
  final roomSubLocalRepository = GetIt.I<RoomSubLocalRepository>();

  final lastChatContacts = <ContactCollection>[].obs;
  final ignoredContacts = <String>[].obs;

  static SelectMemberController get to => Get.find();

  final searchController = TextEditingController();
  final searchInputFocus = FocusNode();
  final selectedAnimatedKey = GlobalKey<AnimatedListState>();

  final contacts = <ContactCollection>[].obs;
  final officialAccount = <ContactCollection>[].obs;
  final groups = <RoomCollection>[].obs;
  final directs = <RoomCollection>[].obs;
  final selectedContacts = <ContactCollection>[].obs;
  final isShowSelectedList = false.obs;
  final memberAndPendingList = <RoomDetailMemberAndPendingModel>[].obs;

  final selectedGroupsAndContacts = <RoomContactModel>[].obs;

  final deletedRoomFromFolder = <RoomContactModel>[].obs;
  final newRoomToFolder = <RoomContactModel>[].obs;

  final isLastPage = false.obs;
  final isManageFolder = false.obs;

  final fromRoomScreen = false.obs;
  final fromSendContact = false.obs;
  final fromRoomDetailInvite = false.obs;
  final initChatRooms = <RoomContactModel>[].obs;

  final roomIdForInvite = ''.obs;

  bool get hasChanged => selectedGroupsAndContacts.isNotEmpty;

  final searchContactNotFound = false.obs;
  RxString searchText = ''.obs;

  bool get limitMember => (selectedContacts.length + memberAndPendingList.length) >= UChatConstant.maxMembersInGroup;

  ChatFolderEntity? chatFolder;

  SelectMemberArguments? arguments;

  ChatRoomDetailMemberController get chatRoomDetailMemberCtl =>
      Get.find<ChatRoomDetailMemberController>(tag: roomIdForInvite.value);

  SelectMemberController({
    this.arguments,
  });

  //TODO: can refactor @mickey
  @override
  void onInit() async {
    searchController.addListener(handleSearch);
    getLastChatContact();
    getContactsToState();
    getGroupsToState();
    getDirectToState();
    initData();
    if (fromRoomDetailInvite.value) {
      filterRoomMemberData();
    }

    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  //
  // ChatFolderController get chatFolderController {
  //   if (!Get.isRegistered<ChatFolderController>()) {
  //     Get.put<ChatFolderController>(ChatFolderController());
  //   }
  //
  //   return Get.find<ChatFolderController>();
  // }

  void initData() {
    if ((Get.arguments != null && Get.arguments is SelectMemberArguments) || arguments != null) {
      final SelectMemberArguments args = (Get.arguments ?? arguments);

      if (args.isManageFolder == true) {
        isManageFolder.value = args.isManageFolder;
        initChatRooms.assignAll(args.contactAndGroupList);
        fromRoomScreen.value = args.fromRoomScreen;
        chatFolder = args.chatFolderCollection;
        if (args.contactAndGroupList.isNotEmpty) {
          isShowSelectedList(true);
          selectedGroupsAndContacts.assignAll(args.contactAndGroupList);
        }
      } else if (args.fromSendContact == true) {
        fromSendContact.value = args.fromSendContact;
      } else if (args.fromRoomDetailInvite == true) {
        fromRoomDetailInvite.value = args.fromRoomDetailInvite;
        roomIdForInvite.value = args.roomId ?? '';
        memberAndPendingList.value = args.roomDetailMemberList;
      } else {
        Get.back();
      }
    }
  }

  Future<void> getContactsToState() async {
    try {
      final contactEntities = await GetIt.I<GetCanChatWithContactUseCase>().call(NoParams());
      final contactCollections = contactEntities.toCollections();

      if (fromRoomDetailInvite.value == true) {
        final memberAndPendingIds = memberAndPendingList.map((e) => e.accountId).toList();
        contactCollections.removeWhere((contact) => memberAndPendingIds.contains(contact.id));
        contacts(contactCollections);
      } else {
        contacts(contactCollections);
      }
    } catch (e, stackTrace) {
      _log.e('getContactsToState error: $e', e, stackTrace);
    }
  }

  Future<void> handleSearch() async {
    searchText.value = searchController.text.toLowerCase();

    // 1) Contact search
    try {
      final contactEntities = await GetIt.I<SearchCanChatWithContactUseCase>().call(searchText.value);
      final contactCollections = contactEntities.toCollections();
      if (fromRoomDetailInvite.value == true) {
        final memberAndPendingIds = memberAndPendingList.map((e) => e.accountId).toList();
        contactCollections.removeWhere((contact) => memberAndPendingIds.contains(contact.id));
        contacts(contactCollections);
      } else {
        contacts(contactCollections);
      }
    } catch (e, stackTrace) {
      _log.e('searchCanChatWithContact error: $e', e, stackTrace);
      contacts([]);
    }

    // 2) Group search
    try {
      final groupList = await roomLocalRepository.searchRoomTypeGroup(searchText.value);
      final processedGroups = await _processGroupList(groupList);
      groups(processedGroups);
    } catch (error) {
      groups([]); // Set empty list on error to prevent UI issues
      _log.e('searchRoomTypeGroup error: $error');
    }
  }

  Future<void> getGroupsToState() async {
    try {
      final groupList = await roomLocalRepository.getRoomTypeGroup();
      final processedGroups = await _processGroupList(groupList);
      groups(processedGroups);
    } catch (error, stackTrace) {
      _log.e('getGroupsToState error: $error', error, stackTrace);
      groups([]); // Set empty list on error to prevent UI issues
    }
  }

  // Helper method to process group lists
  Future<List<RoomCollection>> _processGroupList(List<dynamic> groupList) async {
    if (groupList.isEmpty) return [];

    final futures = groupList.map((group) => _processGroup(group));
    final results = await Future.wait(futures, eagerError: false);

    return results.whereType<RoomCollection>().toList();
  }

  Future<RoomCollection?> _processGroup(RoomEntity group) async {
    try {
      RoomCollection collection = RoomCollection.fromEntity(group);

      if (isManageFolder.value) {
        // For manage folder, check subscription's hasMessage
        final sub = await roomSubLocalRepository.getRoomSubscriptionWithRoomId(group.id);
        if (sub == null || sub.hasMessage != true) {
          return null; // Skip this group
        }

        // Get member count efficiently
        final roomData = await RoomDataModel.fromRoomSubscription(
          RoomSubscriptionCollection.fromEntity(sub),
          getMemberFromLocalDb: true,
        );
        collection.memberCount = roomData.members.length;
      } else {
        // For non-manage folder, get member count directly
        final roomData = await RoomDataModel.fromRoom(
          collection,
          getMemberFromLocalDb: true,
        );
        collection.memberCount = roomData.members.length;
      }

      return collection;
    } catch (e, stackTrace) {
      _log.e('_processGroup error for group ${group.id}: $e', e, stackTrace);
      return null; // Return null for failed processing
    }
  }

  void filterRoomMemberData() {
    if (arguments != null && arguments!.roomMember.isNotEmpty) {
      final roomMember = arguments!.roomMember;
      final roomMemberIds = roomMember.map((e) => e.accountId).toList();
      contacts.removeWhere((element) => roomMemberIds.contains(element.id));
    }
  }

  Future<void> getDirectToState() async {
    try {
      final roomSubList = await roomSubLocalRepository.getLatestDirectChatRooms(limit: 999);
      // Filter out items with hasMessage != true
      final finalSubs = roomSubList.where((sub) => sub.hasMessage == true).toList();
      final directsResult = <RoomCollection>[];

      // For each subscription, get the actual RoomCollection
      for (var sub in finalSubs) {
        try {
          final room = await roomLocalRepository.getRoomSync(sub.roomId!);
          if (room != null) {
            directsResult.add(RoomCollection.fromEntity(room));
          }
        } catch (err) {
          _log.e('getRoomSync error: $err');
        }
      }

      if (isManageFolder.value == true) {
        directsResult.removeWhere(
          (element) =>
              (element.isDirect && element.firstOtherInRoom?.account?.isOfficial == true) ||
              element.firstOtherInRoom == null ||
              element.roomType != RoomType.direct,
        );
      }
      directs(directsResult);
    } catch (error) {
      _log.e('getDirectToState getLatestDirectChatRooms error: $error');
    }
  }

  void handleClearSearch() {
    searchController.clear();
    getContactsToState();
  }

  void handleBack(BuildContext context) async {
    if (selectedContacts.isNotEmpty) {
      await _showDiscardDialog(context);
      return;
    } else {
      Get.back();
    }
  }

  Future<void> _showDiscardDialog(BuildContext context) async {
    UChatNewDialog.showDialog(
      context: context,
      title: 'Discard selected friends'.tr,
      description: 'Are you sure you want to cancel the selected friends? '.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Confirm'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
      cancelTextColor: context.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () {
        Get.back();
      },
    );
  }

  void handleLimitReached(BuildContext context) async {
    if (selectedContacts.length == 10) {
      await _showDiscardDialog(context);
    } else {
      Get.back();
    }
  }

  Future<void> handleBackForManageFolder({bool? fromAppbarCloseButton = false}) async {
    if (hasChanged) {
      final isConfirm = await UChatDialog.showDialog(
        title: 'Discard folder creation'.tr,
        description: 'Are you sure you want to discard creating this folder?'.tr,
        confirmButtonColor: const Color(0xFFFF1552),
        showCloseButton: true,
      );
      if (isConfirm) {
        Get.back();
        if (fromAppbarCloseButton == true) {
          Get.close(2);
        }
      }
    } else {
      Get.back();
      if (fromAppbarCloseButton == true) {
        Get.close(2);
      }
    }
  }

  void handleCreateGroup() {
    if (selectedContacts.isEmpty) return;
    Get.toNamed(Routes.groupCreateFinal);
  }

  Future<void> handleManageFolderAddChatDone() async {
    if (fromRoomScreen.value) {
      if (newRoomToFolder.isEmpty && deletedRoomFromFolder.isEmpty) {
        Get.back();
        return;
      }

      UChatLoading.show(status: 'Saving...'.tr);
      // await chatFolderController.updateChatFolderNormal(
      //   folder: chatFolder!,
      //   newRoomList: newRoomToFolder,
      //   deletedRoomList: deletedRoomFromFolder,
      // );
      UChatLoading.hide();
      UChatLoading.success(message: 'Saved'.tr);
      Get.back();
    } else {
      Get.back(result: selectedGroupsAndContacts);
    }
  }

  void handleSelectCheckbox(ContactCollection contact) {
    searchInputFocus.unfocus();
    int index = selectedContacts.indexWhere((element) => element.id == contact.id);

    // If the contact is already selected, remove it
    if (index >= 0) {
      selectedContacts.removeAt(index);
    } else {
      // If user tries to exceed the limit
      if (limitMember == true) {
        _showMemberLimitReachedDialog();
        return;
      }
      // Otherwise, add the contact
      selectedContacts.add(contact);
    }
  }

  void _showMemberLimitReachedDialog() {
    final context = Get.context;
    if (context == null) return;

    UChatNewDialog.showSingleButtonDialog(
      context: context,
      title: 'Member Limit Reached'.tr,
      description: 'You’ve reached the maximum of 200 members for this group. Unable to add more participants.'.tr,
      confirmText: 'Got it'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
    );
  }

  void handleSelectCheckboxForAddToFolder(dynamic data) {
    searchInputFocus.unfocus();
    RoomContactModel? allData;
    if (data is ContactCollection) {
      allData = RoomContactModel(data: data, type: RoomContactType.contact);
    } else if (data is RoomCollection) {
      allData = RoomContactModel(data: data, type: RoomContactType.room);
    } else if (data is RoomContactModel) {
      allData = data;
    }
    int index = selectedGroupsAndContacts.indexWhere((element) => element.id == allData?.id);

    if (index >= 0) {
      selectedGroupsAndContacts.removeAt(index);
    } else {
      if (selectedGroupsAndContacts.length >= UserController.instance.maxRoomInChatFolder) {
        showPopupLimit();
        return;
      }

      if (allData != null) {
        selectedGroupsAndContacts.add(allData);
      }
    }

    if (allData != null) {
      if (!deletedRoomFromFolder.contains(allData) && initChatRooms.contains(allData)) {
        // if the room is in the folder and not in the selected list, add it to the deleted list
        deletedRoomFromFolder.add(allData);
      } else {
        // if the room is in the folder and in the selected list, remove it from the deleted list
        deletedRoomFromFolder.remove(allData);
      }

      if (newRoomToFolder.contains(allData)) {
        // if the room is in the selected list and in the new list, remove it from the new list
        newRoomToFolder.remove(allData);
      } else if (!newRoomToFolder.contains(allData) && !initChatRooms.contains(allData)) {
        // if the room is not in the new list and not in the folder, add it to the new list
        newRoomToFolder.add(allData);
      }
    }
  }

  Future<void> getLastChatContact() async {
    try {
      final roomSubList = await roomSubLocalRepository.getLatestDirectChatRooms();
      for (final sub in roomSubList) {
        try {
          final roomId = sub.roomId;
          if (roomId == null || roomId.isEmpty) continue;

          final firstOtherInRoom = await roomMemberLocalRepository.getFirstOtherInRoom(roomId);
          if (firstOtherInRoom?.account.id != null &&
              !ignoredContacts.contains(firstOtherInRoom?.account.id) &&
              !(firstOtherInRoom?.account.isOfficial ?? false)) {
            await retrieveTheContact(firstOtherInRoom!);
          }
        } catch (e, stackTrace) {
          _log.e('Error getFirstOtherInRoom', e, stackTrace);
        }

        // Limit to 5 recent contacts
        if (lastChatContacts.length == 5) {
          break;
        }
      }
    } catch (e, stackTrace) {
      _log.e('Error getting the last chat contact', e, stackTrace);
    }
  }

  Future<void> retrieveTheContact(RoomMemberEntity firstOtherInRoom) async {
    try {
      final entity = await GetIt.I<GetContactUseCase>().call(
        ContactParams(accountId: firstOtherInRoom.account.id!),
      );
      final contactInfo = entity?.toCollection();
      if (contactInfo != null) {
        if (fromRoomDetailInvite.value == true) {
          if (!memberAndPendingList.any((e) => e.accountId == contactInfo.id)) {
            lastChatContacts.add(contactInfo);
          }
        } else {
          lastChatContacts.add(contactInfo);
        }
      }
    } catch (e, stackTrace) {
      _log.e('error retrieving contact ${firstOtherInRoom.account.id!}.', e, stackTrace);
    }
  }

  Future<void> showPopupLimit() async {
    UChatLoading.showWithIconForManageFolder(status: 'Unable to add \nmore chats'.tr);
    await Future.delayed(const Duration(seconds: 3));
    UChatLoading.hide();
  }

  void handleShareContacts() {
    // Return the selected contacts to the previous screen
    Get.back(result: selectedContacts.toList());
  }

  void handleInviteToRoom({required AddMemberToChatUseCase addMemberToChatUseCase}) async {
    if (selectedContacts.isEmpty) return;
    await handleAddMember(selectedContacts, addMemberToChatUseCase: addMemberToChatUseCase);
  }

  Future<void> handleAddMember(
    List<ContactCollection> contacts, {
    required AddMemberToChatUseCase addMemberToChatUseCase,
  }) async {
    try {
      if (chatRoomDetailMemberCtl.isAbleToAccessGroupMemberSetting == false) {
        await UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
        return;
      }

      await UChatLoading.show(status: 'Sending...'.tr);
      List<String> friendIdList = contacts.map((element) => element.id!).toList();
      await addMemberToChatUseCase.call(
        AddMemberToChatRequest(
          roomId: roomIdForInvite.value,
          friendIdList: friendIdList,
        ),
      );
      Get.back(result: true);
    } on ApiException catch (e, stackTrace) {
      if (e.exceptionType == ApiExceptionType.permissionDenied) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else if (e.exceptionType == ApiExceptionType.accountAlreadyInviteInRoom) {
        UChatNewDialog.showSingleButtonDialog(
          context: Get.context!,
          title: 'Already Invited'.tr,
          description: 'This contact has already been invited to the group.'.tr,
          confirmText: 'Got it'.tr,
          confirmTextColor: Get.context!.theme.appColors.textPrimary,
        );
      } else if (e.exceptionType == ApiExceptionType.roomMemberExceedLimit) {
        UChatNewDialog.showSingleButtonDialog(
          context: Get.context!,
          title: 'Member Limit Reached'.tr,
          description: 'You’ve reached the maximum of 200 members for this group. Unable to add more participants.'.tr,
          confirmText: 'Got it'.tr,
          confirmTextColor: Get.context!.theme.appColors.textPrimary,
        );
      } else {
        _log.e('handleAddMember ApiException error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e,
        );
      }
    } catch (e, stackTrace) {
      _log.e('handleAddMember error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    } finally {
      await UChatLoading.hide();
    }
  }
}
