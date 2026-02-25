import 'dart:io';

Future<Stream<FileSystemEntity>> scanDirectory(String dirPath) async {
  return Directory(dirPath).list(recursive: true).where((entity) => entity is File && entity.path.endsWith('.dart'));
}
