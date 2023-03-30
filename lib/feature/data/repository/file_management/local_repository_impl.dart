import 'package:dropboxclone/feature/data/datasources/file_management/local/local_datasource.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/file_entity.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/file_list_entity.dart';
import 'package:dropboxclone/feature/domain/repository/file_management/local_repository.dart';
import 'package:sqflite_common/sqlite_api.dart';

class LocalRepositoryImpl extends LocalRepository{
  LocalDataSource dataSource;
  @override
  Future<FileEntity> addFile(String filePath) {
 return dataSource.addFile(filePath);
  }

  @override
  Future<FileListEntity> getFiles() {
    return dataSource.getFiles();

  }

  LocalRepositoryImpl({
    required this.dataSource,
  });
}