import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_with_contact_entity.dart';
import 'package:uchat/features/call_log/domain/use_cases/clear_all_call_logs_use_case.dart';
import 'package:uchat/features/call_log/domain/use_cases/delete_selected_call_logs_use_case.dart';
import 'package:uchat/features/call_log/domain/use_cases/get_call_logs_with_contact_use_case.dart';
import 'package:uchat/features/call_log/domain/use_cases/get_local_call_logs_with_contact_use_case.dart';
import 'package:uchat/features/call_log/domain/use_cases/search_call_logs_with_contact_use_case.dart';
import 'package:uchat/features/call_log/domain/use_cases/search_local_call_logs_with_contact_use_case.dart';
import 'package:uchat/features/call_log/presentation/controllers/call_log_screen_controller.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class CallLogSelectScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  static CallLogSelectScreenController get instance => Get.find();

  static const pageSize = 50;

  ConnectivityController get connectivityCtl => ConnectivityController.instance;

  ScrollController? scrollController;
  final searchController = TextEditingController();
  final searchInputFocus = FocusNode();

  // Rx variables for call logs & pagination.
  final callLogs = <CallLogWithContactEntity>[].obs;
  final selectedCallLogs = <CallLogWithContactEntity>[].obs;
  final currentPage = 1.obs;
  final isLoading = false.obs;
  final hasMore = true.obs;

  final keyword = ''.obs;

  static const _debounceTag = 'select-search-debouncer';

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController()..addListener(_onScroll);
    fetchInitial();
  }

  @override
  void onClose() {
    searchController.dispose();
    searchInputFocus.dispose();
    scrollController?.removeListener(_onScroll);
    scrollController?.dispose();
    EasyDebounce.cancel(_debounceTag);
    super.onClose();
  }

  void _onScroll() {
    final controller = scrollController;
    if (controller == null || !controller.hasClients) return;

    if (controller.position.pixels >= controller.position.maxScrollExtent - 200) {
      loadMore();
    }
  }

  // === Fetching

  Future<void> fetchInitial() async {
    currentPage.value = 1;
    hasMore.value = true;
    await getLocalCallLogs();
    await fetchData();
  }

  Future<void> getLocalCallLogs() async {
    try {
      final result = await GetIt.I<GetLocalCallLogsWithContactUseCase>().call(
        const GetLocalCallLogsWithContactUseCaseParams(limit: pageSize),
      );

      if (result.isNotEmpty) {
        callLogs.assignAll(result);
      }
    } catch (e, stackTrace) {
      _log.e('getLocalCallLogs error in CallLogSelectScreenController.', e, stackTrace);
    }
  }

  Future<void> searchLocalCallLogs() async {
    if (keyword.value.trim().isEmpty) {
      await getLocalCallLogs();
      return;
    }

    try {
      final result = await GetIt.I<SearchLocalCallLogsWithContactUseCase>().call(
        SearchLocalCallLogsWithContactUseCaseParams(
          keyword: keyword.value,
          limit: pageSize,
        ),
      );

      callLogs.assignAll(result);
    } catch (e, stackTrace) {
      _log.e('searchLocalCallLogs error in CallLogSelectScreenController.', e, stackTrace);
    }
  }

  /// If `keyword` is empty => normal fetch
  /// else => search
  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      PaginationPayload<CallLogWithContactEntity>? result;

      if (keyword.value.trim().isEmpty) {
        result = await GetIt.I<GetCallLogsWithContactUseCase>().call(
          GetCallLogsWithContactUseCaseParams(
            page: currentPage.value,
            pageSize: pageSize,
          ),
        );
      } else {
        result = await GetIt.I<SearchCallLogsWithContactUseCase>().call(
          SearchCallLogsWithContactUseCaseParams(
            keyword: keyword.value,
            page: currentPage.value,
            pageSize: pageSize,
          ),
        );
      }

      final data = result.data?.toList() ?? [];
      if (currentPage.value == 1) {
        callLogs.assignAll(data);
      } else {
        callLogs.addAll(data);
      }
      if (currentPage.value >= result.totalPages) {
        hasMore.value = false;
      }
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('fetchData error in CallLogSelectScreenController.', e, stackTrace);
      if (Get.isDialogOpen != true) {
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e is Exception ? e : null,
        );
      }
    }

    isLoading.value = false;
  }

  /// Load more (infinite scroll)
  Future<void> loadMore() async {
    if (!hasMore.value || isLoading.value) return;
    currentPage.value++;
    await fetchData();
  }

  // === Searching

  Future<void> handleSearch(String searchText) async {
    keyword.value = searchText;

    EasyDebounce.debounce(
      _debounceTag,
      const Duration(milliseconds: 200),
      () async {
        currentPage.value = 1;
        hasMore.value = true;
        await searchLocalCallLogs();
        await fetchData();
      },
    );
  }

  // === Selection

  void handleSelectItem(CallLogWithContactEntity item) {
    // Check if item with the same ID is already in selectedCallLogs
    final index = selectedCallLogs.indexWhere((log) => log.id == item.id);
    if (index >= 0) {
      // It's already selected, so remove
      selectedCallLogs.removeAt(index);
    } else {
      // Not selected yet, so add
      selectedCallLogs.add(item);
    }
  }

  // === Deletion

  /// Delete ALL logs from the server + local
  Future<void> handleClearAllCallLogs(BuildContext context) async {
    if (callLogs.isEmpty) return;

    final confirmed = await UChatNewDialog.showDialog(
      context: context,
      title: 'Delete all calls'.tr,
      description: 'This will delete all call records from your history'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Clear'.tr,
      confirmTextColor: context.theme.appColors.textError,
      cancelTextColor: context.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () async {
        try {
          await GetIt.I<ClearAllCallLogsUseCase>().call(
            NoParams(),
          );
          callLogs.clear();
          selectedCallLogs.clear();

          // Also remove them from call log screen
          try {
            final callLogCtl = Get.find<CallLogScreenController>();
            callLogCtl.callLogs.clear();
          } catch (e, stackTrace) {
            _log.e('Could not find CallLogScreenController: ', e, stackTrace);
          }
          Get.back();
        } on FailedHostLookupException catch (_) {
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } catch (e, stackTrace) {
          _log.e('handleClearAllCallLogs error in CallLogSelectScreenController.', e, stackTrace);
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
            e: e is Exception ? e : null,
          );
        }
      },
    );

    if (confirmed != true) return;
  }

  /// Delete only the currently selected logs in a single request
  Future<void> handleDeleteAllSelectedCallLogs(BuildContext context) async {
    if (selectedCallLogs.isEmpty) return;

    final confirmed = await UChatNewDialog.showDialog(
      context: context,
      title: 'Delete @count selected calls'.trParams({
        'count': selectedCallLogs.length.toString(),
      }),
      description: 'Permanently remove these calls. This action can’t be undone.'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Delete'.tr,
      confirmTextColor: context.theme.appColors.textError,
      cancelTextColor: context.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () async {
        final ids = selectedCallLogs.map((e) => e.id).toList();
        try {
          await GetIt.I<DeleteSelectedCallLogsUseCase>().call(
            ids,
          );
          // Remove them from local data
          callLogs.removeWhere((log) => ids.contains(log.id));
          selectedCallLogs.clear();

          // Also remove them from call log screen
          try {
            final callLogCtl = Get.find<CallLogScreenController>();
            callLogCtl.callLogs.removeWhere((log) => ids.contains(log.id));
          } catch (e) {
            _log.e('Could not find main CallLogScreenController: $e');
          }
          Get.back();
        } on FailedHostLookupException catch (_) {
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } catch (e, stackTrace) {
          _log.e('handleDeleteAllSelectedCallLogs error in CallLogSelectScreenController.', e, stackTrace);
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
            e: e is Exception ? e : null,
          );
        }
      },
    );

    if (confirmed != true) return;
  }
}
