import 'package:uchat/utils/date.dart';

enum SecretChatExpireStatus {
  expired, // Secret chat is already expired.
  lessThanAnHour, // Secret chat will expire in less than an hour.
  sameDay, // Secret chat will expire today and expire in more than an hour.
  moreThanOneDay; // Secret chat will expire tomorrow or later.
}

SecretChatExpireStatus calculateSecretChatExpireStatus({
  required DateTime now,
  required DateTime expireAt,
}) {
  final timeDuration = expireAt.difference(now);

  if (timeDuration.isNegative) {
    return SecretChatExpireStatus.expired;
  } else if (timeDuration.inHours < 1) {
    return SecretChatExpireStatus.lessThanAnHour;
  } else if (expireAt.isSameDay(now) == true) {
    return SecretChatExpireStatus.sameDay;
  } else {
    return SecretChatExpireStatus.moreThanOneDay;
  }
}
