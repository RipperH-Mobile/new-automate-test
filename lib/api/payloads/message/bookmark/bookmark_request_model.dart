class BookmarkRequestDataModel {
  String msgId;
  List<String>? fileIds;

  BookmarkRequestDataModel({
    required this.msgId,
    this.fileIds,
  });
}
