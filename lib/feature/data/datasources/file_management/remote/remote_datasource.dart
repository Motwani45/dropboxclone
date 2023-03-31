import 'package:dropboxclone/core/error/file_management/file_management_error.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/remote/remote_file_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class RemoteDataSource{
  Future<Either<FileManagementError,RemoteFileEntity>> startUpload({required String userId,required String fileName,required String filePath});
}