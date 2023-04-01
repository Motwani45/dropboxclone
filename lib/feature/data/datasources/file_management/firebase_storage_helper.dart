import 'dart:io';

import 'package:dropboxclone/core/error/file_management/file_management_error.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/db_helper.dart';
import 'package:dropboxclone/feature/data/models/file_management/remote_file_model.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/remote/remote_file_entity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';

class FirebaseStorageHelper{
  final DatabaseHelper helper=DatabaseHelper();
  final FirebaseStorage firebaseStorage=FirebaseStorage.instance;
  Future<Either<FileManagementError,RemoteFileEntity>> startUpload({required String userId,required String fileName,required String filePath}) async{
    try {
      File file =File(filePath);
      Reference reference= firebaseStorage.ref().child("$userId/$fileName");
      return Either<FileManagementError, RemoteFileEntity>.right(
          RemoteFileModel(filePath: filePath,
              reference: reference
          ));
    }
    catch(e){
      return Either.left(FileManagementError());
    }

  }
}



