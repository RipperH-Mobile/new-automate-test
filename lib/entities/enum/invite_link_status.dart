import 'package:get/get.dart';

enum InviteLinkStatus {
  on,
  off;

  factory InviteLinkStatus.from(bool val) {
    return val ? InviteLinkStatus.on : InviteLinkStatus.off;
  }

  String get displayValue {
    switch (this) {
      case InviteLinkStatus.on:
        return 'On'.tr;
      case InviteLinkStatus.off:
        return 'Off'.tr;
    }
  }

  bool get toBool {
    switch (this) {
      case InviteLinkStatus.on:
        return true;
      case InviteLinkStatus.off:
        return false;
    }
  }
}
