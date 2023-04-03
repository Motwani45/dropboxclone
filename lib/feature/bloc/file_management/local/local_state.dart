
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_list_entity.dart';

abstract class LocalState{
  final bool isLoading;
  final FileListEntity files;

  const LocalState({
    required this.isLoading,
    required this.files,
  });
}
class LocalStateInitialState extends LocalState{
  const LocalStateInitialState({required super.files,required super.isLoading,});
}
class LocalStateGetFiles extends LocalState{
  const LocalStateGetFiles({required super.files,required super.isLoading,});
}




