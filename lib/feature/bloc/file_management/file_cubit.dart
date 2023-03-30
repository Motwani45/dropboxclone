import 'package:dropboxclone/feature/bloc/file_management/file_state.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/local/local_datasource_impl.dart';
import 'package:dropboxclone/feature/data/repository/file_management/local_repository_impl.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/file_list_entity.dart';
import 'package:dropboxclone/feature/domain/usecase/file_management/add_file_usecase.dart';
import 'package:dropboxclone/feature/domain/usecase/file_management/get_files_usecase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileCubit extends Cubit<FileState>{
 FileCubit():super(const FileStateInitialState(files:[], isLoading: false));
 final AddFileUsecase addFileUsecase=AddFileUsecase(LocalRepositoryImpl(
     dataSource: LocalDataSourceImpl()));
 final GetFilesUsecase getFilesUsecase=GetFilesUsecase(LocalRepositoryImpl(dataSource: LocalDataSourceImpl()));

 void addFile() async{
  FilePickerResult? filePickerResult=await FilePicker.platform.pickFiles();
  if(filePickerResult==null){
   print("HERE1");
   emit(FileStateGetFiles(files: state.files, isLoading: false));
   return;
  }
  print("HERE2");
  emit(FileStateGetFiles(files: state.files, isLoading: true));
  String filePath=filePickerResult.files.first.path!;
  await addFileUsecase.call(filePath);
  getFiles();
 }

 void getFiles() async{
  FileListEntity listEntity= await getFilesUsecase.call();
  if(listEntity.isEmpty){
   emit(FileStateInitialState(files: [], isLoading: false));
  }
  else{
   emit(FileStateGetFiles(files: listEntity, isLoading: false));
  }
 }




}