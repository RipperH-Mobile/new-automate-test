class UnblockContactRequest {
  List<String> friendAccountIds;

  UnblockContactRequest({
    required this.friendAccountIds,
  });

  Map<String, dynamic> toMap() {
    final map = {
      'friendAccountIds': friendAccountIds,
    };

    return map;
  }
}
