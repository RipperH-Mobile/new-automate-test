import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfigEnvUtil {
  static final ConfigEnvUtil _instance = ConfigEnvUtil._internal();
  factory ConfigEnvUtil() => _instance;
  ConfigEnvUtil._internal();
  Map<String, dynamic> _config = {};
  String env = 'dev';
  Future<String> initialize() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;
    if (packageName.endsWith('.sit')) {
      env = 'sit';
    } else if (packageName.endsWith('.uat')) {
      env = 'uat';
    }
    return env;
  }

  Future<Map<String, String>> getDotEnv() async {
    final fileName = 'integration_test/.env.$env';
    await dotenv.load(fileName: fileName);
    return dotenv.env;
  }
}
