import 'package:mason_logger/mason_logger.dart';

final logger = Logger();

String? greenStyle(String? m) {
  return green.wrap(m);
}

String? debugInfoStyle(String? m) {
  return cyan.wrap(m);
}

String? debugDetailStyle(String? m) {
  return blue.wrap(m);
}