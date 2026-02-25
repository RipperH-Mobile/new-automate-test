import 'package:emoji_extension/emoji_extension.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_emoji_packages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_emoji_package_items_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/set_default_emoji_request.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/entities/models/default_emoji_item_model.dart';
import 'package:uchat/entities/models/emoji_list_item_model.dart';
import 'package:uchat/entities/models/emoji_item_model.dart';
import 'package:uchat/features/chat_room/domain/entities/emoji_package_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/emoji_package_with_items_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_emoji_packages_items_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_emoji_packages_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/react_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/update_default_emoji_use_case.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
// import 'package:uchat/utils/message_reaction_helper.dart';

class CustomizeReactionController extends GetxController {
  final MessageEntity message;
  final GetEmojiPackagesItemsUseCase getEmojiPackagesItemsUseCase;
  final GetEmojiPackagesUseCase getEmojiPackagesUseCase;
  final UpdateDefaultEmojiUseCase updateDefaultEmojiUseCase;
  final ReactMessageUseCase reactMessageUseCase;
  final LoggerService log;

  CustomizeReactionController({
    required this.message,
    required this.getEmojiPackagesItemsUseCase,
    required this.getEmojiPackagesUseCase,
    required this.updateDefaultEmojiUseCase,
    required this.reactMessageUseCase,
    required this.log,
  });

  int packagesPage = 1;
  int packagesPageSize = 20;

  final packagesPagingController = PagingController<int, EmojiPackageEntity>(firstPageKey: 1);

  final emojiList = RxMap<String, List<EmojiListItemModel>>();
  final accountDefaultEmojiItems = <DefaultEmojiItemModel>[].obs;
  final customizingEmojiList = <DefaultEmojiItemModel>[].obs;
  final currentEmojiPackage = Rxn<EmojiPackageEntity>();
  final currentYourCustomizeEmojiIndex = 0.obs;
  final customizing = false.obs;
  final loading = false.obs;

  List<EmojiListItemModel> get currentEmojiList => emojiList[currentEmojiPackage.value?.id ?? ''] ?? [];

  set currentEmojiList(List<EmojiListItemModel> value) => emojiList[currentEmojiPackage.value?.id ?? ''] = value;

  @override
  void onInit() async {
    setAccountDefaultEmojiItems();
    getEmojis();
    super.onInit();
  }

  void setAccountDefaultEmojiItems() {
    final user = UserController.instance.currentUser.value;
    final accountDefaultEmojiItems = user?.accountDefaultEmojiItems;
    if (accountDefaultEmojiItems == null) return;
    this.accountDefaultEmojiItems.value = accountDefaultEmojiItems;
  }

  Future<PaginationPayload<EmojiPackageEntity>?> _getEmojiPackages(int page) async {
    try {
      return await getEmojiPackagesUseCase.call(
        GetEmojiPackagesRequest(
          page: page,
          pageSize: packagesPageSize,
        ),
      );
    } catch (e, stackTrace) {
      if (e is FailedHostLookupException) {
        UChatNewDialog.showYouAreOfflineDialog(
          context: Get.context!,
        );
      } else {
        log.e('Error fetching emoji packages', e, stackTrace);
        packagesPagingController.appendLastPage([]);
      }
    }
    return null;
  }

  Future<PaginationPayload<EmojiPackageWithItemsEntity>?> _getEmojiPackagesItems(String emojiPackageId) async {
    try {
      return await getEmojiPackagesItemsUseCase.call(GetEmojiPackageItemsRequest(
        emojiPackageId: emojiPackageId,
      ));
    } catch (e, stackTrace) {
      if (e is FailedHostLookupException) {
        UChatNewDialog.showYouAreOfflineDialog(
          context: Get.context!,
        );
      } else {
        log.e('Error fetching emoji package items', e, stackTrace);
        packagesPagingController.appendLastPage([]);
      }
    }
    return null;
  }

  void getEmojis() async {
    if (currentEmojiPackage.value != null) return;

    final emojiPackagesRes = await _getEmojiPackages(packagesPage);
    if (emojiPackagesRes == null) {
      packagesPagingController.appendLastPage([]);
      return;
    }

    final emojiPackages = emojiPackagesRes.data?.toList();
    if (emojiPackages == null) {
      packagesPagingController.appendLastPage([]);
      return;
    }

    if (accountDefaultEmojiItems.isNotEmpty || emojiPackages.isNotEmpty) {
      currentEmojiPackage.value = emojiPackages.first;
      final isLastPage = emojiPackagesRes.page == emojiPackagesRes.totalPages;
      if (isLastPage) {
        packagesPagingController.appendLastPage(emojiPackages);
      } else {
        final nextPageKey = packagesPage + 1;
        packagesPagingController.appendPage(emojiPackages, nextPageKey);
        packagesPagingController.addPageRequestListener((pageKey) {
          loadMorePackages(pageKey);
        });
      }
      loading.value = true;

      final currentEmojiPackageId = currentEmojiPackage.value?.id;
      if (currentEmojiPackageId == null) {
        loading.value = false;
        return;
      }

      final emojiPackagesItemsRes = await _getEmojiPackagesItems(currentEmojiPackageId);
      if (emojiPackagesItemsRes == null) {
        loading.value = false;
        return;
      }
      final emojiPackagesItems = emojiPackagesItemsRes.data?.toList();
      if (emojiPackagesItems == null) {
        loading.value = false;
        return;
      }

      currentEmojiList = _createEmojiListItemModel(
        currentEmojis: accountDefaultEmojiItems,
        emojiPackageItems: emojiPackagesItems.firstOrNull?.emojiItems ?? [],
      );
    } else {
      packagesPagingController.appendLastPage([]);
    }
    loading.value = false;
  }

  void loadMorePackages(int pageKey) async {
    final emojiPackagesRes = await _getEmojiPackages(pageKey);
    if (emojiPackagesRes == null) {
      packagesPagingController.appendLastPage([]);
      return;
    }

    final emojiPackages = emojiPackagesRes.data?.toList();
    if (emojiPackages == null) {
      packagesPagingController.appendLastPage([]);
      return;
    }

    final isLastPage = emojiPackagesRes.page == emojiPackagesRes.totalPages;
    if (isLastPage) {
      packagesPagingController.appendLastPage(emojiPackages);
    } else {
      final nextPageKey = pageKey + 1;
      packagesPagingController.appendPage(emojiPackages, nextPageKey);
    }
  }

  void startCustomizing() {
    customizing.value = true;
    customizingEmojiList.value = accountDefaultEmojiItems.toList();
  }

  void cancelCustomizing() {
    customizing.value = false;
    customizingEmojiList.value = [];
  }

  void saveCustomizing() async {
    customizing.value = false;
    if (const ListEquality().equals(accountDefaultEmojiItems, customizingEmojiList)) {
      return;
    }
    accountDefaultEmojiItems.value = customizingEmojiList.toList();
    customizingEmojiList.value = [];
    try {
      await updateDefaultEmojiUseCase.call(
        UpdateDefaultEmojiRequest(
          defaultEmojiItems: accountDefaultEmojiItems.mapNotNull((e) => e?.emojiItemId).toList(),
        ),
      );
    } catch (e, stackTrace) {
      if (e is FailedHostLookupException) {
        UChatNewDialog.showYouAreOfflineDialog(
          context: Get.context!,
        );
      } else {
        log.e('Error saveCustomizing', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    }
  }

  void selectCustomizeEmoji(int index) {
    currentYourCustomizeEmojiIndex.value = index;
  }

  void changeEmoji(int index) {
    // update active status
    final emojiItems = currentEmojiList.map((e) => e.emojiItem).toList();
    customizingEmojiList[currentYourCustomizeEmojiIndex.value] = DefaultEmojiItemModel(
      fileId: currentEmojiList[index].emojiItem.fileId,
      emojiItemId: emojiItems[index].id,
    );
    currentEmojiList = _createEmojiListItemModel(
      currentEmojis: customizingEmojiList,
      emojiPackageItems: emojiItems,
    );
    emojiList.refresh();
  }

  void resetCustomizing() {
    final user = UserController.instance.currentUser.value;
    final defaultEmojiItems = user?.uchatDefaultEmojiItems;
    if (defaultEmojiItems == null) return;
    customizingEmojiList.value = defaultEmojiItems;
    // update active status
    final emojiItems = currentEmojiList.map((e) => e.emojiItem).toList();
    currentEmojiList = _createEmojiListItemModel(
      currentEmojis: accountDefaultEmojiItems,
      emojiPackageItems: emojiItems,
    );
    emojiList.refresh();
  }

  void selectPackage(EmojiPackageEntity package) async {
    currentEmojiPackage.value = package;
    final packageId = package.id;

    if (packageId == null) return;
    if (emojiList[packageId] != null) return;

    loading.value = true;
    final emojiPackagesItemsRes = await _getEmojiPackagesItems(packageId);
    if (emojiPackagesItemsRes == null) {
      loading.value = false;
      return;
    }
    final emojiPackagesItems = emojiPackagesItemsRes.data?.toList();
    if (emojiPackagesItems == null) {
      loading.value = false;
      return;
    }

    emojiList[packageId] = _createEmojiListItemModel(
      currentEmojis: accountDefaultEmojiItems,
      emojiPackageItems: emojiPackagesItems.firstOrNull?.emojiItems ?? [],
    );
    emojiList.refresh();
    loading.value = false;
  }

  List<EmojiListItemModel> _createEmojiListItemModel({
    required List<DefaultEmojiItemModel> currentEmojis,
    required List<EmojiItemModel> emojiPackageItems,
  }) {
    return emojiPackageItems.map(
      (e) {
        bool active = currentEmojis.firstWhereOrNull(
              (element) => element.emojiItemId == e.id,
            ) ==
            null;
        return EmojiListItemModel(
          emojiItem: e,
          active: active,
        );
      },
    ).toList();
  }

  void selectEmoji(String emojiId) async {
    try {
      await reactMessageUseCase.call(
        ReactMessageParams(
          message: message,
          emojiId: emojiId,
        ),
      );
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(
        context: Get.context!,
      );
    } on ApiException catch (e, stackTrace) {
      if (e.type == 'ERR_PERMISSION_DENIED') {
        UChatNewDialog.showPermissionDeniedDialog(
          context: Get.context!,
        );
      } else {
        log.e('Error in selectEmoji', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    } catch (e, stackTrace) {
      log.e('Error in selectEmoji', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }
}
