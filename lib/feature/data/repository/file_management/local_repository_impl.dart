import 'package:dropboxclone/core/error/file_management/file_management_error.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/local/local_datasource.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_entity.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_list_entity.dart';
import 'package:dropboxclone/feature/domain/repository/file_management/local_repository.dart';
import 'package:fpdart/fpdart.dart';

class LocalRepositoryImpl extends LocalRepository{
  LocalDataSource dataSource;
  @override
  Future<Either<FileManagementError,FileEntity>> addFile(String filePath) {
 return dataSource.addFile(filePath);
  }

  @override
  Future<FileListEntity> getFiles() {
    return dataSource.getFiles();

  }

  LocalRepositoryImpl({
    required this.dataSource,
  });

  @override
  void changeSyncStatus(String fileName, String syncStatus) {
    dataSource.changeSyncStatus(fileName, syncStatus);
  }
}