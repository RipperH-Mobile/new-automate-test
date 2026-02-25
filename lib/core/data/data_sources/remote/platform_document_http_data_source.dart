import 'package:uchat/api/http/http_caller.dart';

import '../models/payloads/platform_document/accept_term_and_condition.dart';
import '../models/payloads/platform_document/get_platform_document.dart';
import 'backend_path.dart' as backend_path;

class PlatformDocumentHttpDataSource {
  final HttpCaller httpCaller;

  PlatformDocumentHttpDataSource({required this.httpCaller});

  Future<GetPlatformDocumentResponse?> getPlatformDocument(GetPlatformDocumentRequest request) async {
    final resp = await httpCaller.get(
      backend_path.getPlatformDocument.http,
      data: request.toMap(),
    );

    return resp.mapToResponse<GetPlatformDocumentResponse>(
      (data) => GetPlatformDocumentResponse.fromJson(data),
    );
  }

  Future<void> acceptTermAndCondition(AcceptTermAndConditionRequest request) async {
    final resp = await httpCaller.post(
      backend_path.userAcceptTerm.http,
      data: request.toMap(),
    );

    return resp.data;
  }
}
