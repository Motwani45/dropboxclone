import 'dart:io';

import 'package:dropboxclone/core/enums/file_enum.dart';
import 'package:dropboxclone/core/error/file_management/file_management_error.dart';
import 'package:dropboxclone/core/extension/filesize.dart';
import 'package:dropboxclone/feature/data/models/file_management/file_model.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_entity.dart';
import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entity/file_management/local/file_list_entity.dart';

class DatabaseHelper{
  static Database? _db;

  Future<Database> get db async {
    String path=await dbPath;
    bool isAvail=await databaseExists(path);
    if(isAvail){
      var theDb = await openDatabase(path);
      return theDb;
    }
    _db = await initDb(path);
    return _db!;
  }
  Future<String> get dbPath async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentsDirectory.path, "test.db");
    return path;
  }
  Future<Database> initDb(String path) async {
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Files(fileName TEXT PRIMARY KEY, filePath TEXT, fileSize TEXT, syncStatus TEXT,  fileExtension TEXT)");

  }

  Future<FileListEntity> getFiles() async{
    String query="SELECT * FROM Files";
    Database database=await db;
    final files=await database.rawQuery(query);

    if(files.isEmpty){
      return [];
    }
    return files.map((fileMap) => FileModel(syncStatus: fileMap['syncStatus'] as String, fileName: fileMap['fileName'] as String, fileSize: fileMap['fileSize'] as String, fileExtension: fileMap['fileExtension'] as String, filePath: fileMap['filePath'] as String)).toList().reversed.toList();

  }

  Future<Either<FileManagementError,FileEntity>> addFile(String filePath,int fileBytes) async{
    File file=File(filePath);
    final bytes=await file.readAsBytes();
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path=p.join(documentsDirectory.path,p.basename(file.path));
    File newFile=File(path);
    newFile.writeAsBytes(bytes);
    Database database =await db;
    Map<String,String>values={
      'filePath':newFile.path,
      'syncStatus':FileEnum.NotUploaded.message,
      'fileExtension':p.extension(newFile.path),
      'fileName':p.basename(newFile.path),
      'fileSize':fileBytes.getFileSize()
    };
    try {
      await database.insert(
          "Files", values, conflictAlgorithm: ConflictAlgorithm.abort);
    }
    catch (e){
      return Either<FileManagementError,FileEntity>.left(const FileManagementError(
        message: "File Already There"
      ));
    }
    return Either<FileManagementError,FileEntity>.right(FileModel(syncStatus: values['syncStatus']!, fileName: values['fileName']!, fileSize: values['fileSize']!, fileExtension: values['fileExtension']!, filePath: values['filePath']!));
  }
  Future<int> dbClear() async{
    Database database =await db;
    return database.delete("Files");
  }
  void changeSyncStatus(String fileName,String syncStatus) async{
    Database database =await db;
    await database.rawUpdate('UPDATE Files SET syncStatus = ? WHERE fileName = ?',[syncStatus,fileName]);
  }
}