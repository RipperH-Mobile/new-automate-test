// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uchat/entities/enum/file_progress_state.dart';

class FileStateChangeEvent {
  String fileRef;
  FileProgressState state;

  FileStateChangeEvent({
    required this.fileRef,
    required this.state,
  });

  @override
  String toString() => 'FileStateChangeEvent(fileRef: $fileRef, state: $state)';
}
