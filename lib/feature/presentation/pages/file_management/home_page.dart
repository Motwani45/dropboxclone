
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropboxclone/core/enums/file_enum.dart';
import 'package:dropboxclone/core/utils/loading/loading_screen.dart';
import 'package:dropboxclone/feature/bloc/file_management/internet_connection/internet_cubit.dart';
import 'package:dropboxclone/feature/bloc/file_management/internet_connection/internet_state.dart';
import 'package:dropboxclone/feature/bloc/file_management/local/local_cubit.dart';
import 'package:dropboxclone/feature/bloc/file_management/local/local_state.dart';
import 'package:dropboxclone/feature/bloc/file_management/remote/remote_cubit.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/db_helper.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_entity.dart';
import 'package:dropboxclone/feature/presentation/widgets/file_management/filelisttile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
class HomePage extends StatelessWidget {
  final String userId;
  HomePage({Key? key,required this.userId}) : super(key: key);

  bool internetAvailable=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: const Text("DropBox Clone"),
        ),
        body: BlocListener<InternetCubit,InternetState>(
          listener: (context,state){
            if(state is InternetStateOnConnected){
              internetAvailable=true;
            }
            else if(state is InternetStateNotConnected){
              internetAvailable=false;
            }
          },
          child: BlocBuilder<LocalCubit,LocalState>(
            builder: (builderContext,state){
              print("Internet :$internetAvailable");
              bool canUpload=internetAvailable;

              if(state is LocalStateGetFiles){
                canUpload=internetAvailable;
                print("can Upload: $canUpload");
                if(state.files.isEmpty){
                  return const Center(child:Text("No Files Uploaded Till Now"));
                }
                return ListView.builder(itemBuilder: (context,index){
                  FileEntity fileEntity=state.files[index];
                  if(canUpload&&(fileEntity.syncStatus==FileEnum.UploadFailed.message||fileEntity.syncStatus==FileEnum.NotUploaded.message)) {
                    canUpload=false;
                    print("Here for Upload");
                    context.read<RemoteCubit>().startUpload(userId: userId, fileName: fileEntity.fileName, filePath: fileEntity.filePath);
                    return FileListTile(file: state.files[index],
                      userId: userId,
                      hasInternet: internetAvailable,
                      canUpload: true,);
                  }
                  return FileListTile(file: state.files[index],
                    userId: userId,
                    hasInternet: internetAvailable,
                    canUpload: canUpload,);
                },itemCount: state.files.length,);
              }
              return const Center(child:Text("No Files Uploaded Till Now"));
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // DatabaseHelper().dbClear();
            context.read<LocalCubit>().addFile();
          },
          child: const Icon(Icons.add),
        ),
      );
  }
}