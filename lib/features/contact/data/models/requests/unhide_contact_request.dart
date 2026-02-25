class UnHideContactRequest {
  List<String> friendAccountIds;

  UnHideContactRequest({
    required this.friendAccountIds,
  });

  Map<String, dynamic> toMap() {
    return {'friendAccountIds': friendAccountIds};
  }
}
