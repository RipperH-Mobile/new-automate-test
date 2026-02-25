import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';

import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/domain/params/contact_params.dart';
import 'package:uchat/features/contact/domain/use_cases/get_can_show_in_share_contact_sort_by_display_name_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_use_case.dart';
import 'package:uchat/screens/contact_selection/contact_selection_argruments.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ContactSelectionController extends GetxController {
  final String tag;

  final filteredContacts = <ContactCollection>[].obs;

  final roomDb = GetIt.I<RoomDb>();
  final roomSubDb = GetIt.I<RoomSubscriptionDb>();

  final searchController = TextEditingController();
  final searchKeyword = ''.obs;

  // TODO this variable is unused in ContactSelectionScreen. use it or remove this variable.
  final lastChatContacts = <ContactCollection>[].obs;
  final contacts = <ContactCollection>[].obs;
  final selectedContacts = <ContactCollection>[].obs;

  /// List of contact id that will be ignored
  final ignoredContacts = <String>[].obs;

  /// -1 is unlimited, 0 is not allow
  final maxSelectedContact = (-1).obs;

  late final ContactSelectionArguments arguments;

  bool get showSearchResult => searchKeyword.value.isNotEmpty;

  Timer? _searchDebounce;

  ContactSelectionController({
    required this.tag,
  });

  ChatRoomController get roomCtl {
    // _log.d('tag what inside : $tag');
    return Get.find<ChatRoomController>(tag: tag);
  }

  @override
  void onInit() async {
    if (UChatScreenUtil.instance.isMobile) {
      initArguments();
    }
    getContactsToState();

    searchController.addListener(handleSearchContact);
    super.onInit();
  }

  @override
  onClose() {
    searchController.removeListener(handleSearchContact);
    searchController.dispose();
    super.onClose();
  }

  /// Init arguments from [Get.arguments]
  void initArguments() {
    arguments = Get.arguments as ContactSelectionArguments;
    ignoredContacts(arguments.ignoredContacts);
    maxSelectedContact(arguments.maxSelectedContact);
  }

  RxList<ContactCollection> get displayedContacts {
    if (searchKeyword.value.isEmpty) {
      return contacts;
    } else {
      return filteredContacts;
    }
  }

  void applySearchFilter() {
    final lowerCaseTerm = searchKeyword.value.toLowerCase();

    final filtered = contacts.where((contact) {
      return contact.displayName!.toLowerCase().contains(lowerCaseTerm) ||
          (contact.nickname?.toLowerCase().contains(lowerCaseTerm) ?? false);
    }).toList();

    filteredContacts.value = filtered;
  }

  Future<void> handleSearchContact() async {
    if (_searchDebounce?.isActive ?? false) _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 700), () {
      searchKeyword.value = searchController.text.toLowerCase().trim();
      _log.d('message : ${searchKeyword.value}');
      applySearchFilter();
    });
  }

  // void clearSearchText() {
  //   searchController.clear();
  // }

  /// Get contacts to state
  Future<void> getContactsToState() async {
    try {
      await Future.wait([
        getLastChatContact(),
        (() async => contacts(
              (await GetIt.I<GetCanShowInShareContactSortByDisplayNameUseCase>().call(NoParams())).toCollections(),
            ))(),
      ]);

      if (ignoredContacts.isNotEmpty) {
        // Remove ignored contacts
        lastChatContacts.removeWhere(
          (element) => ignoredContacts.contains(element.id),
        );
        contacts.removeWhere(
          (element) => ignoredContacts.contains(element.id),
        );
      }
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('getContactsToState error.', e, stackTrace);
    }
  }

  /// Get last chat contact
  Future<void> getLastChatContact() async {
    // _log.d('ignoreContact : $ignoredContacts');
    try {
      final roomSubList = await roomSubDb.getLatestDirectChatRooms();

      for (final RoomSubscriptionCollection roomSub in roomSubList) {
        final room = await roomDb.getRoom(roomSub.roomId ?? '');
        if (room != null) {
          final entity = await GetIt.I<GetContactUseCase>().call(ContactParams(
            accountId: room.firstOtherInRoom!.accountId!,
          ));
          final contactInfo = entity?.toCollection();
          if (contactInfo != null) {
            lastChatContacts.add(contactInfo);
          }
        }
      }
    } catch (e, stackTrace) {
      _log.e(
        UChatLogMessage(
          message: 'get last chat contact error',
          error: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  void onLeadingBack() {
    // _log.d('shareContact : $selectedContacts');
    Get.back();
  }

  Future<void> handleShareContactDirectly(ContactCollection contact) async {
    try {
      selectedContacts.add(contact);
      // _log.d('Sharing contact: $contact');

      roomCtl.onShareUChatContact([contact]);

      // _log.d('Shared contact: $contact');
    } catch (e) {
      _log.e('Error while sharing contact directly: $e');
    }
  }
}
