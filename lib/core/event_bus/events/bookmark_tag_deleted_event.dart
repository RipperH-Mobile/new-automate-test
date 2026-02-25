class BookmarkTagDeletedEvent {
  String tagId;

  BookmarkTagDeletedEvent({required this.tagId});

  @override
  String toString() {
    return 'BookmarkTagDeletedEvent{tagId: $tagId}';
  }
}
