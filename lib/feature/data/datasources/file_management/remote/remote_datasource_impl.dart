import 'package:dropboxclone/core/error/file_management/file_management_error.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/firebase_storage_helper.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/remote/remote_datasource.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/remote/remote_file_entity.dart';
import 'package:fpdart/src/either.dart';

class RemoteDataSourceImpl extends RemoteDataSource{
  final FirebaseStorageHelper firebaseStorageHelper=FirebaseStorageHelper();
  @override
  Future<Either<FileManagementError, RemoteFileEntity>> startUpload({ required String userId,required String fileName, required String filePath}) {
    return firebaseStorageHelper.startUpload(userId: userId, fileName: fileName, filePath: filePath);
  }

}