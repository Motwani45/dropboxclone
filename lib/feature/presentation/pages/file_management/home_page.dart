
import 'dart:collection';
import 'package:dropboxclone/core/enums/file_enum.dart';
import 'package:dropboxclone/feature/bloc/file_management/internet_connection/internet_cubit.dart';
import 'package:dropboxclone/feature/bloc/file_management/internet_connection/internet_state.dart';
import 'package:dropboxclone/feature/bloc/file_management/local/local_cubit.dart';
import 'package:dropboxclone/feature/bloc/file_management/local/local_state.dart';
import 'package:dropboxclone/feature/bloc/file_management/remote/remote_cubit.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_entity.dart';
import 'package:dropboxclone/feature/presentation/widgets/file_management/filelisttile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomePage extends StatelessWidget {
  final String userId;
  HomePage({Key? key,required this.userId}) : super(key: key);
  static bool internetAvailable=false;
  static Queue<FileEntity> queue=Queue();
  static bool uploadInProgress=false;
  void changeUploadProgress(){
    uploadInProgress=false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: const Text("DropBox Clone"),
        ),
        body: BlocListener<InternetCubit,InternetState>(
          listener: (listenerContext,state){
            if(state is InternetStateOnConnected){
              internetAvailable=true;
            }
            else if(state is InternetStateNotConnected){
              internetAvailable=false;
            }
              context.read<LocalCubit>().getFiles();
          },
          child: BlocBuilder<LocalCubit,LocalState>(
            builder: (builderContext,state){
              print("BlocBuilder Called");
              print("Internet :$internetAvailable");
              if(state is LocalStateGetFiles){
                if(state.files.isEmpty){
                  return const Center(child:Text("No Files Uploaded Till Now"));
                }
                queue.clear();
                state.files.forEach((element) {
                  if(element.syncStatus==FileEnum.UploadFailed.message||element.syncStatus==FileEnum.NotUploaded.message){
                    queue.addFirst(element);
                  }
                });
                if(!uploadInProgress&&queue.isNotEmpty){
                  FileEntity fileEntity=queue.removeFirst();
                  context.read<RemoteCubit>().startUpload(userId: userId, fileName: fileEntity.fileName, filePath: fileEntity.filePath);
                  uploadInProgress=true;
                }
                return ListView.builder(itemBuilder: (context,index){
                  FileEntity fileEntity=state.files[index];
                  return FileListTile(file: fileEntity,
                    userId: userId,
                    isInternetAvailable: internetAvailable,
                    uploadInProgress: uploadInProgress,
                    changeUploadInProgress: changeUploadProgress,

                  );
                },itemCount: state.files.length,);
              }
              return const Center(child:Text("No Files Uploaded Till Now"));
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<LocalCubit>().addFile(context);
          },
          child: const Icon(Icons.add),
        ),
      );
  }
}