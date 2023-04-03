import 'package:dropboxclone/core/extension/fileenumextension.dart';
import 'package:dropboxclone/feature/bloc/file_management/local/local_cubit.dart';
import 'package:dropboxclone/feature/bloc/file_management/remote/remote_cubit.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_entity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/file_enum.dart';
import '../../../bloc/file_management/remote/remote_state.dart';

class FileListTile extends StatelessWidget {
  final FileEntity file;
  final bool hasInternet;
  final String userId;
  final bool canUpload;

  FileListTile(
      {required this.file, required this.userId, required this.hasInternet,required this.canUpload, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 5.0, horizontal: 10.0,),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 90,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                color: file.syncStatus
                    .getFileEnum()
                    .colorData,
                width: 70,
                height: 70,
                child: file.syncStatus
                    .getFileEnum()
                    .iconData,
              ),
              SizedBox(width: 5),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(file.fileName.length>20?"${file.fileName.substring(0,19)}...":file.fileName),
                    Text(file.fileSize,
                        style: TextStyle(color: Colors.grey))
                  ],
                ),
              ),
              BlocBuilder<RemoteCubit,RemoteState>(builder:(context,state){
                if(state is RemoteStateUploadInProgress &&state.fileName==file.fileName) {
                  print("Here percentage");
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(value: state.percentage/100,),
                      ),
                      Text(state.percentage.toStringAsFixed(1)),
                    ],
                  );
                }
                if(state is RemoteStateUploadCompleted){
                  print("Here complete");
                  context.read<LocalCubit>().changeSyncStatus(file.fileName,FileEnum.UploadComplete.message);
                  context.read<LocalCubit>().getFiles();
                }
                return Container();
              })
            ],
          ),
        ),
      ),
    );
  }
}
