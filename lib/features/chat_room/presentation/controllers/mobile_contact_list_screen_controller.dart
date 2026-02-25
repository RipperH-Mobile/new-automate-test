import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';

// final _log = useLogger();

class MobileContactListScreenController extends GetxController {
  final String tag;
  final contacts = <Contact>[].obs;
  final TextEditingController textController = TextEditingController();
  final searchTerm = ''.obs;
  final filteredContacts = <Contact>[].obs;
  final sharedContacts = <String>[].obs;

  Timer? _searchDebounce;

  MobileContactListScreenController({required this.tag});

  RxList<Contact> get allContacts => contacts;

  bool get isSharingLimitReached => sharedContacts.length >= 10;

  ChatRoomController get roomCtl => Get.find<ChatRoomController>(tag: tag);

  @override
  void onInit() {
    loadContacts();

    textController.addListener(() {
      // Cancel any existing timer
      if (_searchDebounce?.isActive ?? false) {
        _searchDebounce?.cancel();
      }

      // Schedule a new debounce timer
      _searchDebounce = Timer(const Duration(milliseconds: 300), () {
        final query = textController.text.trim().toLowerCase();
        searchTerm.value = textController.text.trim();
        _filterContacts(query);
      });
    });

    super.onInit();
  }

  @override
  void onClose() {
    _searchDebounce?.cancel();
    super.onClose();
  }

  Future<void> loadContacts() async {
    final List<Contact> loadedContacts = await FlutterContacts.getContacts(withProperties: true);
    contacts.value = loadedContacts;
    // _log.d("Fetched contacts: ${loadedContacts.length}");
    filteredContacts.value = loadedContacts;
  }

  void _filterContacts(String query) {
    if (query.isEmpty) {
      filteredContacts.value = contacts;
      return;
    }

    final isNumericTerm = RegExp(r'^[0-9]+$').hasMatch(query);
    final results = contacts.where((contact) {
      if (isNumericTerm) {
        // Compare numeric phone values
        return contact.phones.any(
          (phone) => phone.number.replaceAll(RegExp(r'[^0-9]'), '').contains(query),
        );
      } else {
        // Compare displayName
        return contact.displayName.toLowerCase().contains(query);
      }
    }).toList();

    filteredContacts.value = results;
  }

  void clearSearch() {
    textController.clear();
  }

  Future<void> shareContact(List<Contact> contact) async {
    // Return the selected contacts to the previous screen
    Get.back(result: contact.toList());
  }
}
