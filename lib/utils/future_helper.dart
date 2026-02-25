import 'dart:async';

import 'package:get/get.dart';

Future<bool> waitRxBool(RxBool what, bool expect) {
  final Completer<bool> c = Completer();

  if (what() == expect) {
    return Future.value(expect);
  }

  once<bool>(
    what,
    (callback) {
      c.complete(callback);
    },
    condition: () => what() == expect,
  );

  return c.future;
}
