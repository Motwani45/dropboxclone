import 'package:dropboxclone/feature/domain/entity/file_management/local/file_entity.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_list_entity.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class LocalRepository{
  Future<FileEntity> addFile(String filePath);
  Future<FileListEntity> getFiles();
}