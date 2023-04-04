import 'package:dropboxclone/core/error/file_management/file_management_error.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_entity.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_list_entity.dart';
import 'package:fpdart/fpdart.dart';
abstract class LocalRepository{
  Future<Either<FileManagementError,FileEntity>> addFile(String filePath);
  Future<FileListEntity> getFiles();
  void changeSyncStatus(String fileName,String syncStatus);
}