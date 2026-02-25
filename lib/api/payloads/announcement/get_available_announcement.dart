class GetAvailableAnnouncementRequest {
  final DateTime? lastGetAt;

  GetAvailableAnnouncementRequest({
    this.lastGetAt,
  });

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};

    if (lastGetAt != null) {
      data['lastGetAt'] = lastGetAt?.toUtc().toIso8601String();
    }

    return data;
  }
}
