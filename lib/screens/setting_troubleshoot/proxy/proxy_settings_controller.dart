import 'package:get/get.dart';
import 'package:uchat/api/http.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/utils/app_env.dart';

class ProxySettingsController extends GetxController {
  final isEnabled = false.obs;
  final ip = ''.obs;
  final port = 0.obs;

  void updateEnable(bool value) => isEnabled.value = value;

  void updateIp(String value) => ip.value = value;

  void updatePort(String value) => port.value = int.parse(value);

  ///
  /// Load the proxy settings from the configuration
  ///
  Future<void> loadConfig() async {
    // Load the proxy settings from the configuration
    final general = ConfigDb().general;

    isEnabled.value = await general.getBoolWithDefault(
      key: ConfigDb.getProxyIsEnabledKey(),
      defaultValue: AppEnv.proxyEnabled,
    );

    ip.value = await general.getStringWithDefault(
      key: ConfigDb.getProxyIpKey(),
      defaultValue: AppEnv.proxyHost,
    );

    port.value = await general.getIntWithDefault(
      key: ConfigDb.getProxyPortKey(),
      defaultValue: AppEnv.proxyPort,
    );
  }

  ///
  /// Save the proxy settings to the configuration
  ///
  Future<void> saveConfig() async {
    // Save the proxy settings to the configuration
    final general = ConfigDb().general;

    await general.saveConfig(
      key: ConfigDb.getProxyIsEnabledKey(),
      value: isEnabled.value,
    );

    await general.saveConfig(
      key: ConfigDb.getProxyIpKey(),
      value: ip.value,
    );

    await general.saveConfig(
      key: ConfigDb.getProxyPortKey(),
      value: port.value,
    );

    await HttpCaller.instance.loadProxyConfig();
  }
}
