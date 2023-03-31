import 'dart:collection';

import 'package:dropboxclone/feature/bloc/file_management/local/local_state.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/local/local_datasource_impl.dart';
import 'package:dropboxclone/feature/data/repository/file_management/local_repository_impl.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_entity.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_list_entity.dart';
import 'package:dropboxclone/feature/domain/usecase/file_management/local/add_file_usecase.dart';
import 'package:dropboxclone/feature/domain/usecase/file_management/local/get_files_usecase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalCubit extends Cubit<LocalState>{
 LocalCubit():super(const LocalStateInitialState(files:[], isLoading: false));
 final AddFileUsecase addFileUsecase=AddFileUsecase(LocalRepositoryImpl(
     dataSource: LocalDataSourceImpl()));
 final GetFilesUsecase getFilesUsecase=GetFilesUsecase(LocalRepositoryImpl(dataSource: LocalDataSourceImpl()));

 void addFile() async{
  FilePickerResult? filePickerResult=await FilePicker.platform.pickFiles();
  if(filePickerResult==null){
   print("HERE1");
   emit(LocalStateGetFiles(files: state.files, isLoading: false));
   return;
  }
  print("HERE2");
  emit(LocalStateGetFiles(files: state.files, isLoading: true));
  String filePath=filePickerResult.files.first.path!;
  await addFileUsecase.call(filePath);
  getFiles();
 }

 void getFiles() async{
  FileListEntity listEntity= await getFilesUsecase.call();
  if(listEntity.isEmpty){
   emit(LocalStateInitialState(files: [], isLoading: false));
  }
  else{
   emit(LocalStateGetFiles(files: listEntity, isLoading: false));
  }
 }




}