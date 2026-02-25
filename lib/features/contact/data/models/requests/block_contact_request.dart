class BlockContactRequest {
  List<String> friendAccountIds;

  BlockContactRequest({
    required this.friendAccountIds,
  });

  Map<String, dynamic> toMap() {
    final map = {
      'friendAccountIds': friendAccountIds,
    };

    return map;
  }
}
