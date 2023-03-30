import 'package:dropboxclone/core/enums/file_enum.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/file_entity.dart';

class FileModel extends FileEntity{
  FileModel({required super.syncStatus, required super.fileName, required super.fileSize, required super.fileExtension, required super.filePath});

}