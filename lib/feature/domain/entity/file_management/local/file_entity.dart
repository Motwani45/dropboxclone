import 'package:dropboxclone/core/enums/file_enum.dart';
import 'package:equatable/equatable.dart';

class FileEntity extends Equatable{
  final String syncStatus;
  final String fileName;
  final String fileSize;
  final String fileExtension;
  final String filePath;


  @override
  List<Object?> get props => [fileName,syncStatus];

  FileEntity({
    required this.syncStatus,
    required this.fileName,
    required this.fileSize,
    required this.fileExtension,
    required this.filePath,
  });
}