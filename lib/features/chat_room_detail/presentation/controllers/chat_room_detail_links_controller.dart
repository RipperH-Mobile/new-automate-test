import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uchat/core/domain/services/url_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/room_links_response.dart';
import 'package:uchat/features/chat_room_detail/domain/params/fetch_room_links_params.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/fetch_room_links_use_case.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_links_argument.dart';

final _log = useLogger();

class ChatRoomDetailLinksController extends GetxController {
  final String tag;

  ChatRoomDetailLinksController({required this.tag});

  final roomLinks = <RoomLinksResponse>[].obs;
  final PagingController<int, RoomLinksResponse> pagingController = PagingController(firstPageKey: 0);

  final linkCount = 0.obs;
  String roomId = '';

  @override
  void onInit() {
    if (Get.arguments is ChatRoomDetailLinksArgument) {
      final arg = Get.arguments as ChatRoomDetailLinksArgument;
      roomId = arg.roomId;
      linkCount.value = arg.totalLinks;
      if (roomId != '') {
        pagingController.addPageRequestListener((page) {
          _fetchRoomLinks(page);
        });
      }
    }

    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  Future<void> _fetchRoomLinks(int page) async {
    try {
      final response = await GetIt.I<FetchRoomLinksUseCase>().call(FetchRoomLinksParams(
        roomId: roomId,
        page: page + 1,
      ));
      if (response != null) {
        roomLinks.addAll(response.data!.toList());
        final isLastPage = page + 1 >= response.totalPages;
        if (isLastPage) {
          pagingController.appendLastPage(response.data!.toList());
        } else {
          pagingController.appendPage(response.data!.toList(), page + 1);
        }
      }
    } catch (e, stackTrace) {
      _log.e('fetchRoomLinks error.', e, stackTrace);
    }
  }

  Future<void> openLink(String url) async {
    try {
      await GetIt.I<UrlService>().open(url);
    } catch (e, stackTrace) {
      _log.e('Open link error.', e, stackTrace);
    }
  }
}
