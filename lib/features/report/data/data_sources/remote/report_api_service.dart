import 'package:uchat/api/backend_path.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/features/report/data/models/report_request.dart';

class ReportApiService {
  final HttpCaller httpCaller;

  ReportApiService({
    required this.httpCaller,
  });

  Future<dynamic> sendReportTicket({
    required ReportRequest request,
  }) async {
    return httpCaller.post(
      BackendPath.openSupportTicket.http,
      data: request.toJson(),
    );
  }
}
