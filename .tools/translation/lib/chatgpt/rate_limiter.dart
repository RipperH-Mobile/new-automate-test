import 'dart:collection';

class RateLimiter {
  final int maxRequestsPerMinute;
  final Queue<DateTime> requestTimes = Queue();

  RateLimiter({this.maxRequestsPerMinute = 60});

  Future<void> waitForSlot() async {
    final now = DateTime.now();

    while (requestTimes.isNotEmpty && now.difference(requestTimes.first) > Duration(minutes: 1)) {
      requestTimes.removeFirst();
    }

    if (requestTimes.length >= maxRequestsPerMinute) {
      final oldestRequest = requestTimes.first;
      final waitTime = Duration(minutes: 1) - now.difference(oldestRequest);
      await Future.delayed(waitTime);
    }

    requestTimes.add(now);
  }
}
