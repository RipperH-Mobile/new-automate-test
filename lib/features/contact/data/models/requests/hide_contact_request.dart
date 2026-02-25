class HideContactRequest {
  List<String> friendAccountIds;

  HideContactRequest({
    required this.friendAccountIds,
  });

  Map<String, dynamic> toMap() {
    return {'friendAccountIds': friendAccountIds};
  }
}
