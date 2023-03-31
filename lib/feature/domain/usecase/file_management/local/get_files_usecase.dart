import 'package:dropboxclone/feature/domain/entity/file_management/local/file_list_entity.dart';
import 'package:dropboxclone/feature/domain/repository/file_management/local_repository.dart';

class GetFilesUsecase{
  final LocalRepository localRepository;
  const GetFilesUsecase(this.localRepository);

  Future<FileListEntity> call(){
    return localRepository.getFiles();
  }
}