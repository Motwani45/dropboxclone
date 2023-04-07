import 'package:firebase_storage/firebase_storage.dart';

class RemoteFileEntity {
  final String filePath;
  final UploadTask uploadTask;

  const RemoteFileEntity({
    required this.filePath,
    required this.uploadTask,
  });
}