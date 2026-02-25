enum AlbumQueueType {
  upload,
  download;

  String get value {
    switch (this) {
      case AlbumQueueType.upload:
        return 'UPLOAD';
      case AlbumQueueType.download:
        return 'DOWNLOAD';
    }
  }

  static from(String val) {
    switch (val) {
      case 'UPLOAD':
        return AlbumQueueType.upload;
      case 'DOWNLOAD':
        return AlbumQueueType.download;
    }
  }
}
