class UnsentOrRemoveImagesLocalEvent {
  final String id;
  final List<String> removedFileIds;

  UnsentOrRemoveImagesLocalEvent(
    this.id,
    this.removedFileIds,
  );

  @override
  String toString() => 'UnsentOrRemoveImagesLocalEvent(id: $id, removedFileCount: ${removedFileIds.length})';
}
