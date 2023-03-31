import 'package:dropboxclone/feature/domain/entity/file_management/local/file_entity.dart';
import 'package:dropboxclone/feature/domain/repository/file_management/local_repository.dart';

class AddFileUsecase{
  final LocalRepository localRepository;
  const AddFileUsecase(this.localRepository);
  Future<FileEntity> call(String filePath){
    return localRepository.addFile(filePath);
  }
}