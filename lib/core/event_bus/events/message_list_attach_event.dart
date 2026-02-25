class MessageListAttachedEvent {
  final int messageSliverKey;
  final bool isAttached;

  const MessageListAttachedEvent({
    required this.messageSliverKey,
    required this.isAttached,
  });

  @override
  String toString() => 'MessageListAttachedEvent(messageSliverKey: $messageSliverKey, isAttached: $isAttached)';

  @override
  bool operator ==(covariant MessageListAttachedEvent other) {
    if (identical(this, other)) return true;

    return other.messageSliverKey == messageSliverKey && other.isAttached == isAttached;
  }

  @override
  int get hashCode => messageSliverKey.hashCode ^ isAttached.hashCode;
}
