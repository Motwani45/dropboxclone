import 'dart:io';

import 'package:dropboxclone/feature/domain/entity/file_management/local/file_entity.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_list_entity.dart';

abstract class LocalDataSource{
  Future<FileEntity> addFile(String filePath);
  Future<FileListEntity> getFiles();
  void changeSyncStatus(String fileName,String syncStatus);
}