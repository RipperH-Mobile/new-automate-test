class OaMenuUnpublishEvent {
  String id;
  DateTime lastUpdatedAt;

  OaMenuUnpublishEvent({
    required this.id,
    required this.lastUpdatedAt,
  });

  @override
  String toString() => 'OaMenuUnpublishEvent(id: $id, lastUpdatedAt: $lastUpdatedAt)';
}
