
class InitStateSeqsResponse {
  int defaultSeq = 0;
  int friendSeq = 0;
  int messageSeq = 0;
  int roomSeq = 0;
  int roomSubscriptionSeq = 0;

  InitStateSeqsResponse({
    this.defaultSeq = 0,
    this.messageSeq = 0,
    this.roomSeq = 0,
    this.roomSubscriptionSeq = 0,
    this.friendSeq = 0,
  });

  factory InitStateSeqsResponse.fromMap(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final resp = InitStateSeqsResponse();

    if (data['seqs'] != null && data['seqs'] is List) {
      final seqItems = data['seqs'] as List<dynamic>;
      for (final seqItem in seqItems) {
        final group = seqItem['group'] as String;
        final seq = seqItem['seq'] as int;

        switch (group) {
          case 'DEFAULT':
            resp.defaultSeq = seq;
            break;
          case 'MESSAGE':
            resp.messageSeq = seq;
            break;
          case 'ROOM':
            resp.roomSeq = seq;
            break;
          case 'ROOM_SUBSCRIPTION':
            resp.roomSubscriptionSeq = seq;
            break;
          case 'FRIEND':
            resp.friendSeq = seq;
            break;
        }
      }
    }

    return resp;
  }
}
