enum AlbumRoleType {
  editor,
  viewer,
}

extension AlbumRoleTypeExtension on AlbumRoleType {
  String get value {
    switch (this) {
      case AlbumRoleType.editor:
        return 'EDITOR';
      case AlbumRoleType.viewer:
        return 'VIEWER';
    }
  }
}
