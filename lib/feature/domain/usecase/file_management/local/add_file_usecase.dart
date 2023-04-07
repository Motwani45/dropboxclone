import 'package:dropboxclone/feature/domain/entity/file_management/local/file_entity.dart';
import 'package:dropboxclone/feature/domain/repository/file_management/local_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/file_management/file_management_error.dart';

class AddFileUsecase{
  final LocalRepository localRepository;
  const AddFileUsecase(this.localRepository);
  Future<Either<FileManagementError,FileEntity>> call(String filePath,int fileBytes){
    return localRepository.addFile(filePath,fileBytes);
  }
}