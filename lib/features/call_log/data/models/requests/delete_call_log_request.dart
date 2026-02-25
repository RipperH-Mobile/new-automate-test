class DeleteCallLogRequest {
  final List<String>? callLogIds;

  DeleteCallLogRequest({
    this.callLogIds,
  });

  Map<String, dynamic> toJson() {
    if (callLogIds != null && callLogIds!.isNotEmpty) {
      return {'callLogIds': callLogIds};
    }
    return {};
  }
}
