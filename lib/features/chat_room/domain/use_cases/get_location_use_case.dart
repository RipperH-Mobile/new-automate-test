import 'package:get/get.dart';
import 'package:uchat/api/payloads/map/map_info.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

class GetLocationUseCase extends SimpleUseCase<MapInfoResponse?, NoParams> {
  final LoggerService log;

  GetLocationUseCase({
    required this.log,
  });
  @override
  Future<MapInfoResponse?> call(NoParams params) async {
    try {
      MapInfoResponse? mapSelector;
      mapSelector = await Get.toNamed(Routes.map) as MapInfoResponse?;

      if (mapSelector != null) {
        return mapSelector;
      } else {
        return null;
      }
    } catch (e) {
      log.e('GetLocationUseCase error.', e);
      return null;
    }
  }
}
