
import 'dart:io';

import 'package:dropboxclone/feature/data/datasources/file_management/db_helper.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/local/local_datasource.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_entity.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_list_entity.dart';
import 'package:sqflite_common/sqlite_api.dart';

class LocalDataSourceImpl extends LocalDataSource{
  final databaseHelper= DatabaseHelper();
  @override
  Future<FileEntity> addFile(String filePath) async{
  return await databaseHelper.addFile(filePath);
  }

  @override
  Future<FileListEntity> getFiles() async{
  return await databaseHelper.getFiles();
  }


}