import 'package:firebase_storage/firebase_storage.dart';

class RemoteFileEntity {
  final String filePath;
  final Reference reference;

  const RemoteFileEntity({
    required this.filePath,
    required this.reference,
  });
}