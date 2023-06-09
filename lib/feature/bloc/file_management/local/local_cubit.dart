import 'package:dropboxclone/feature/bloc/file_management/local/local_state.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_list_entity.dart';
import 'package:dropboxclone/feature/domain/usecase/file_management/local/add_file_usecase.dart';
import 'package:dropboxclone/feature/domain/usecase/file_management/local/change_syncstatus_usecase.dart';
import 'package:dropboxclone/feature/domain/usecase/file_management/local/get_files_usecase.dart';
import 'package:dropboxclone/feature/presentation/widgets/error_dialog/duplicate_error_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalCubit extends Cubit<LocalState>{
 final AddFileUsecase addFileUsecase;
 final GetFilesUsecase getFilesUsecase;
 final ChangeSyncStatusUsecase changeSyncStatusUsecase;

 LocalCubit(
 {
  required this.changeSyncStatusUsecase,
  required this.getFilesUsecase,
  required this.addFileUsecase
}
     ):super(const LocalStateInitialState(files:[], isLoading: false));

 void addFile(BuildContext context) async{
  FilePickerResult? filePickerResult=await FilePicker.platform.pickFiles();
  if(filePickerResult==null){
   emit(LocalStateGetFiles(files: state.files, isLoading: false));
   return;
  }
 emit(LocalStateGetFiles(files: state.files, isLoading: true));
  String filePath=filePickerResult.files.first.path!;
  int fileBytes=filePickerResult.files.first.size;
  final resultType=await addFileUsecase.call(filePath,fileBytes);
  resultType.fold((l) => showDuplicateErrorDialog(context, l), (r) => getFiles());
 }

 void getFiles() async{
  FileListEntity listEntity= await getFilesUsecase.call();
  if(listEntity.isEmpty){
   emit(const LocalStateGetFiles(files: [], isLoading: false));
  }
  else{
   emit(LocalStateGetFiles(files: listEntity, isLoading: false));
  }
 }

 void changeSyncStatus(String fileName,String syncStatus){
changeSyncStatusUsecase.call(fileName, syncStatus);
 }


}