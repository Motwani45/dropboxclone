import 'dart:io';

import 'package:dropboxclone/feature/bloc/file_management/remote/remote_state.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/remote/remote_datasource_impl.dart';
import 'package:dropboxclone/feature/data/repository/file_management/remote_repository_impl.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/remote/remote_file_entity.dart';
import 'package:dropboxclone/feature/domain/usecase/file_management/remote/start_upload_usecase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteCubit extends Cubit<RemoteState>{
  RemoteCubit():super(const RemoteStateUploadNotStarted(fileName: ""));
  final StartUploadUsecase startUploadUsecase =StartUploadUsecase(remoteRepository: RemoteRepositoryImpl(dataSource: RemoteDataSourceImpl()));
void startUpload({required String userId,required String fileName,required String filePath}) async{
final resultType=await startUploadUsecase.call(userId: userId, fileName: fileName, filePath: filePath);
RemoteFileEntity? fileEntity;
resultType.fold((l) => null, (r) => fileEntity=r);
UploadTask task=fileEntity!.reference.putFile(File(filePath));
task.snapshotEvents.listen((event) {
  double percentage=(event.bytesTransferred/event.totalBytes)*100;
  if(percentage==100){
  emit(RemoteStateUploadCompleted(fileName: fileName));
  }
  else{
    emit(RemoteStateUploadInProgress(percentage: percentage, fileName: fileName));
  }
}).onError((error,stackTrace){
  emit(RemoteStateFileUploadFailed(fileName: fileName));
}
);
}
}