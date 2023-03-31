import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
class RemoteFileEntity extends Equatable{
  final String filePath;
  final Reference reference;

  const RemoteFileEntity({
    required this.filePath,
    required this.reference,
  });

  @override
  List<Object?> get props => [filePath,reference];
 }