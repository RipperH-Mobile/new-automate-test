import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/use_cases/use_case.dart';

class DoNotShowPromotionTodayUseCase extends SimpleUseCase<void, NoParams> {
  final ConfigInstance configDbGeneral;

  DoNotShowPromotionTodayUseCase({required this.configDbGeneral});

  @override
  Future<void> call(NoParams params) async {
    final now = DateTime.now();
    await configDbGeneral.saveConfig(
      key: ConfigDb.getDontShowCoinPromotionDateTimeConfigKey(),
      value: now,
    );
  }
}
