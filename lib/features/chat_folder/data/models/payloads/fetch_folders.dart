
class FetchFoldersParams {
  final int page;
  final int pageSize;

  FetchFoldersParams({
    this.page = 1,
    this.pageSize = 100,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'page': page,
      'pageSize': pageSize,
    };
  }
}
