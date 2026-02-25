extension DurationExtensions on Duration {
  /// Converts Duration to string format: 00:00 (MM:SS) using intl
  /// if hours are present, format is: H:MM:SS
 String toMMSS() {
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');
    if (inHours > 0) {
      final hours = inHours.toString().padLeft(2, '0');
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }
}
