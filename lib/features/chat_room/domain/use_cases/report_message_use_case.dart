import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_api_service.dart';
import 'package:uchat/features/chat_room/data/models/requests/send_report_request.dart';

class ReportMessageUseCase {
  ReportMessageUseCase({
    required this.chatRoomApiService,
  });

  final ChatRoomApiService chatRoomApiService;

  Future<void> call(OpenSupportTicketRequest params) async {
    return await chatRoomApiService.openSupportTicket(params);
  }
}
