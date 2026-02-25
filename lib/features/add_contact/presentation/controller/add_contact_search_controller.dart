import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart' as lib_phone_number;
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/use_cases/get_enabled_country_list_use_case.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/add_contact/presentation/controller/add_contact_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/enabled_counties_bottom_sheet_screen.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/open_direct_chat_request.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_arguments.dart';
import 'package:uchat/features/chat_room/domain/use_cases/open_direct_chat_and_save_to_db_use_case.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/data/models/requests/add_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/decline_friend_request.dart';
import 'package:uchat/features/contact/data/models/requests/search_contact_request.dart';
import 'package:uchat/features/contact/domain/params/put_contact_params.dart';
import 'package:uchat/features/contact/domain/use_cases/put_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/search_contact_use_case.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

import '../../domain/use_cases/accept_friend_requested_use_case.dart';
import '../../domain/use_cases/decline_friend_requested_use_case.dart';

final _log = useLogger();

const searchTypeUsername = 'USERNAME';
const searchTypePhone = 'PHONE';

class AddContactSearchController extends GetxController {
  static AddContactSearchController get instance => Get.find();

  final String? initialSearchKeyword;

  AddContactSearchController({this.initialSearchKeyword});

  PhoneNumber initialISO = PhoneNumber(isoCode: 'TH');
  final enabledCountries = Rx<List<lib_phone_number.CountryWithPhoneCode>>([]);
  final currentCountry = Rx<lib_phone_number.CountryWithPhoneCode?>(null);

  final searchType = searchTypeUsername.obs;
  final searchText = ''.obs;

  final searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  final phoneNumber = ''.obs;
  final isLoading = false.obs;
  final isResultNotFound = false.obs;
  final isMe = false.obs;

  final searchResult = Rx<ContactCollection?>(null);

  final roomDb = GetIt.I<RoomDb>();
  final roomMemberDb = GetIt.I<RoomMemberDb>();

  AddContactController get addContactCrl {
    try {
      return Get.find<AddContactController>();
    } catch (e) {
      return Get.put<AddContactController>(AddContactController());
    }
  }

  AcceptFriendRequestedUseCase get acceptFriendRequestedUseCase {
    return GetIt.I.get<AcceptFriendRequestedUseCase>();
  }

  DeclineFriendRequestedUseCase get declineFriendRequestedUseCase {
    return GetIt.I.get<DeclineFriendRequestedUseCase>();
  }

  @override
  void onInit() async {
    super.onInit();

    /// flutter_libphonenumber's init for every enabled countries data
    await lib_phone_number.init();
    initCurrentCountryData();

    searchController.addListener(() {
      searchText(searchController.text);

      EasyDebounce.debounce(
        'handleSearch contact',
        const Duration(milliseconds: 1000),
        () {
          handleSearch();
        },
      );

      if (searchText() == '') {
        searchResult.value = null;
        isLoading(false);
        isResultNotFound(false);
      }
    });

    if (initialSearchKeyword != null) {
      handleAddByQrScan(username: initialSearchKeyword);
    }
  }

  void handleTabSearchOption(String value) async {
    searchType.value = value;
    onClearInput();
  }

  void onClearInput() {
    searchText.value = '';
    searchController.text = '';
  }

  void handleSearch() async {
    try {
      if (searchText() == '') return;

      if (ConnectivityController.instance.isOffline) {
        if (ConnectivityController.instance.isConnectMaintenanceWasOn.value) {
          UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
        } else {
          showOfflineDialog();
        }

        return;
      }

      String searchTextValue = searchText.value;

      isLoading(true);

      searchTextValue = searchTextValue.replaceAll(' ', '');
      if (searchType.value == searchTypePhone) {
        // Use phone number data from InternationalPhoneNumberInput widget in search_input.dart
        // This will handle leading 0 in TH phone number and handle country code
        searchTextValue = phoneNumber.value;
      }

      if (searchTextValue.isEmpty) {
        return;
      }

      final req = SearchContactRequest(
        username: searchTextValue,
        type: searchType.value,
      );
      final res = await GetIt.I<SearchContactUseCase>().call(req);

      searchResult.value = res.contact?.toCollection();
      isLoading.value = false;
      isResultNotFound.value = false;
      isMe.value = UserController.instance.isCurrentUser(res.contact?.id ?? '');
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () {
        searchResult.value = null;
        isLoading.value = false;
        isResultNotFound.value = true;
        _log.e('searchContact error.', e, stackTrace);
      });
    }
  }

  Future<void> handleAcceptFriend(String id) async {
    if (ConnectivityController.instance.isOffline) {
      if (ConnectivityController.instance.isConnectMaintenanceWasOn.value) {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
      } else {
        showOfflineDialog();
      }

      return;
    }

    try {
      UChatLoading.show(status: 'Accepting...'.tr);
      final res = await acceptFriendRequestedUseCase.call(AddContactRequest(friendAccountId: id));

      if (res?.contact case final contact?) {
        searchResult.update((val) {
          if (val == null) {
            return;
          }

          val.isFriend = true;
        });

        // Add to contacts database
        await GetIt.I<PutContactUseCase>().call(PutContactParams(contact: contact.toEntity()));

        // Notify ui to update.
        eventBus.fire(ContactUpdateEvent(contact: contact));
      }

      eventBus.fire(AcceptRequestEvent(id: id));
    } on ApiFriendLimitExceedException catch (e, stackTrace) {
      _log.e('handleAcceptFriend on ApiFriendLimitExceedException error.', e, stackTrace);
      UChatNewDialog.showSingleButtonDialog(
        context: Get.context!,
        title: 'Friend Limit Reached'.tr,
        description:
            'You have reached the maximum number of friends. To add a new friend, please remove someone from your contact list.'
                .tr,
        confirmText: 'Got it'.tr,
        confirmTextColor: Get.theme.appColors.textPrimary,
      );
    } catch (e, stackTrace) {
      _log.e('handleAcceptFriend error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
    }

    await UChatLoading.hide();
  }

  void handleAddFriend() async {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickAddFriendSearchPage,
      eventProperties: EventProperty.clickAddFriendSearchPage(
        friendType: (searchResult()?.isOfficial ?? false) ? 'OA' : 'Friend',
      ),
    );

    if (ConnectivityController.instance.isOffline) {
      if (ConnectivityController.instance.isConnectMaintenanceWasOn.value) {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
      } else {
        showOfflineDialog();
      }

      return;
    }

    try {
      await UChatLoading.show(status: 'updating'.tr);
      final req = AddContactRequest(friendAccountId: searchResult()!.id!);
      final res = await acceptFriendRequestedUseCase.call(req);

      if (res?.contact case final contact?) {
        searchResult.update((val) {
          if (val == null) {
            return;
          }

          val.isFriend = true;
        });

        // Add to contacts database
        await GetIt.I<PutContactUseCase>().call(PutContactParams(contact: contact.toEntity()));

        // Notify ui to update.
        eventBus.fire(ContactUpdateEvent(contact: contact));
      }
    } on ApiFriendLimitExceedException catch (_) {
      await UChatNewDialog.showFriendLimitExceededDialog();
    } on ApiOfficialAccountLimitExceedException catch (_) {
      await UChatNewDialog.showOfficialAccountLimitExceededDialog();
    } catch (e, stackTrace) {
      _log.e('handleAddFriend error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
    }

    await UChatLoading.hide();
  }

  void handleDeclineFriendRequest() async {
    if (ConnectivityController.instance.isOffline) {
      if (ConnectivityController.instance.isConnectMaintenanceWasOn.value) {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
      } else {
        showOfflineDialog();
      }

      return;
    }

    try {
      await UChatLoading.show(status: 'Loading...'.tr);
      final friendId = searchResult()?.id;

      if (friendId == null) {
        await UChatLoading.hide();
        return;
      }

      await declineFriendRequestedUseCase.call(
        DeclineFriendRequest(friendAccountId: friendId),
      );

      addContactCrl.friendRequestList.removeWhere((e) => e.id == friendId);
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      _log.e('handleDeclineFriendRequest error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
    }

    await UChatLoading.hide();
  }

  void handleOpenChat() async {
    await UChatLoading.show(status: 'Processing...'.tr);

    final contactId = searchResult.value!.id!;
    String? id = await roomMemberDb.getDirectRoomIdByOtherIdInRoom(contactId);
    RoomCollection? room = await roomDb.getRoom(id ?? '');

    try {
      if (room == null) {
        _log.d('getDirectRoomByFirstOtherAccountId roomNotFound');

        final roomEntity = await GetIt.I<OpenDirectChatAndSaveToDbUseCase>().call(
          OpenDirectChatRequest(friendAccountId: contactId),
        );
        if (roomEntity != null) {
          room = RoomCollection.fromEntity(roomEntity);
        }
      }

      if (room != null) {
        Get.offNamedUntil(
          Routes.chatRoomDirect.replaceAll(':id', room.id!),
          (r) => r.settings.name == Routes.home,
          arguments: ChatRoomArguments(room: room, fromPage: 'addContract'),
        );
      }

      await UChatLoading.hide();
      if (!GetPlatform.isMobile) {
        Get.back();
      }
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleChat openDirectChat error.', e, stackTrace);
        await UChatLoading.hide();
        UChatDialog.showExceptionDialog();
      });
    }
  }

  void initCurrentCountryData() async {
    try {
      final List<lib_phone_number.CountryWithPhoneCode> supportedCountries =
          lib_phone_number.CountryManager().countries;
      currentCountry.value = supportedCountries.where((e) => e.countryCode == 'TH').firstOrNull;

      final countries = await GetIt.I<GetEnabledCountryListUseCase>().call(NoParams());

      enabledCountries.value.addAll(supportedCountries.where((e) => countries.countryEnabled.contains(e.countryCode)));
      enabledCountries.value.sort((a, b) => (a.countryName ?? '').compareTo(b.countryName ?? ''));

      final indexTH = enabledCountries.value.indexWhere((e) => e.countryCode == 'TH');
      final indexTW = enabledCountries.value.indexWhere((e) => e.countryCode == 'TW');

      /// Move Taiwan to the top
      if (indexTW != -1) {
        final taiwan = enabledCountries.value.removeAt(indexTW);
        enabledCountries.value.insert(0, taiwan);
      }

      /// Move Thailand to the top
      if (indexTH != -1) {
        final thailand = enabledCountries.value.removeAt(indexTH);
        enabledCountries.value.insert(0, thailand);
      }

      /// At the end [Thailand] will be index[0] and [Taiwan] will be index[1]
      /// In case one or both of these are not on the [enabledCountries] list
      /// The sorting still be correct
    } catch (e, stackTrace) {
      _log.e('initCurrentCountryData error.', e, stackTrace);
    }
  }

  void onOpenCountryListBottomSheet() async {
    await showCupertinoModalBottomSheet(
      expand: true,
      context: Get.context!,
      builder: (_) {
        return EnabledCountriesBottomSheetScreen(
          countryList: enabledCountries.value,
          selectedCountryCode: currentCountry.value?.countryCode ?? 'TH',
          onSelectItem: (country) {
            Get.back();
            currentCountry.value = country;
          },
        );
      },
    );
  }

  void onPhoneNumberChange(String value) async {
    final phoneCode = '+${currentCountry.value?.phoneCode ?? '66'}';

    GetIt.I<TaxonomyService>().sendEvent(
      EventName.inputPhoneNumberAddFriendPage,
      eventProperties: EventProperty.inputPhoneNumberAddFriendPage(
        countryName: '${currentCountry.value?.countryName}($phoneCode)',
      ),
    );

    try {
      final number = PhoneNumber(
        phoneNumber: value,
        isoCode: currentCountry.value?.countryCode ?? '',
        dialCode: currentCountry.value?.phoneCode ?? '',
      );

      String raw = await PhoneNumber.getParsableNumber(number);
      raw = '$phoneCode$raw';
      phoneNumber.value = raw.replaceAll(' ', '');
    } on PlatformException catch (e, stackTrace) {
      if (e.code == 'NumberParseException') {
        _log.w('NumberParseException error.', e, stackTrace);
      } else {
        _log.e('onPhoneNumberChange error.', e, stackTrace);
      }
    } catch (e, stackTrace) {
      _log.e('onPhoneNumberChange error.', e, stackTrace);
    }
  }

  void handleAddByQrScan({String? username}) {
    final usernameArg = username ?? Get.parameters['username'];
    if (usernameArg != null) {
      searchController.text = usernameArg;
      searchText(usernameArg);
      searchType(searchTypeUsername);
      handleSearch();
    }
  }

  void showOfflineDialog() {
    UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
  }
}
