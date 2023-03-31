import 'dart:io';

import 'package:dropboxclone/feature/bloc/file_management/remote/remote_state.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/remote/remote_datasource.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/remote/remote_datasource_impl.dart';
import 'package:dropboxclone/feature/data/repository/file_management/remote_repository_impl.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/remote/remote_file_entity.dart';
import 'package:dropboxclone/feature/domain/usecase/file_management/remote/start_upload_usecase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteCubit extends Cubit<RemoteState>{
  RemoteCubit():super(const RemoteStateUploadNotStarted());
  final StartUploadUsecase startUploadUsecase =StartUploadUsecase(remoteRepository: RemoteRepositoryImpl(dataSource: RemoteDataSourceImpl()));

void startUpload({required String userId,required String fileName,required String filePath}) async{
final resultType=await startUploadUsecase.call(userId: userId, fileName: fileName, filePath: filePath);
RemoteFileEntity? fileEntity;
resultType.fold((l) => null, (r) => fileEntity=r);
File file =File(fileEntity!.filePath);
UploadTask uploadTask=fileEntity!.reference.putFile(file);
  double percentage=(uploadTask.snapshot.bytesTransferred/uploadTask.snapshot.totalBytes)*100;
  if(percentage==100){
    emit(RemoteStateUploadCompleted());
}
  else{
    emit(RemoteStateUploadInProgress(percentage));
  }
}
}