
import 'package:dropboxclone/feature/domain/repository/file_management/local_repository.dart';

class ChangeSyncStatusUsecase{
final LocalRepository localRepository;
const ChangeSyncStatusUsecase({
  required this.localRepository
});
  void call(String fileName,String syncStatus){
  localRepository.changeSyncStatus(fileName, syncStatus);
  }
}