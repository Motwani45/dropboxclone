import 'package:dropboxclone/core/error/file_management/file_management_error.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/remote/remote_file_entity.dart';
import 'package:dropboxclone/feature/domain/repository/file_management/remote_repository.dart';
import 'package:fpdart/fpdart.dart';

class StartUploadUsecase{
  final RemoteRepository remoteRepository;

  const StartUploadUsecase({
    required this.remoteRepository,
  });
  Future<Either<FileManagementError,RemoteFileEntity>> call({required String userId,required String fileName,required String filePath}){
    return remoteRepository.startUpload(fileName:fileName, filePath:filePath,userId:userId);
  }

}