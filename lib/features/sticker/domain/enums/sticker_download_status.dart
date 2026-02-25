enum StickerDownloadStatus {
  idle,
  inQueue,
  inProgress,
  completed,
  failed,
  cancelled;

  bool get isIdle => this == StickerDownloadStatus.idle;
  bool get isInQueue => this == StickerDownloadStatus.inQueue;
  bool get isInProgress => this == StickerDownloadStatus.inProgress;
  bool get isCompleted => this == StickerDownloadStatus.completed;
  bool get isFailed => this == StickerDownloadStatus.failed;
  bool get isCancelled => this == StickerDownloadStatus.cancelled;
}
