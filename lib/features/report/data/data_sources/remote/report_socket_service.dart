import 'package:uchat/api/backend_path.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/features/report/data/models/report_request.dart';

class ReportSocketService {
  ReportSocketService({
    required this.socketCaller,
  });

  final SocketCaller socketCaller;

  Future<dynamic> sendReportTicket({required ReportRequest request}) async {
    return await socketCaller.emitCallV3(
      BackendPath.openSupportTicket.socket,
      request.toJson(),
    );
  }
}
