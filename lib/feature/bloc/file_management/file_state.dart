
import 'package:dropboxclone/feature/domain/entity/file_management/file_list_entity.dart';

abstract class FileState{
  final bool isLoading;
  final FileListEntity files;

  const FileState({
    required this.isLoading,
    required this.files
  });
}
class FileStateInitialState extends FileState{
  const FileStateInitialState({required super.files,required super.isLoading});
}
class FileStateGetFiles extends FileState{
  const FileStateGetFiles({required super.files,required super.isLoading});
}




