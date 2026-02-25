import 'package:uchat/features/report/data/models/report_response.dart';
import 'package:uchat/features/report/domain/entities/report_entity.dart';

abstract class ReportRepository {
  Future<ReportResponse> sendReportTicket({required ReportEntity request});

  // Future<void> blockFriend({required ReportEntity request});
}
