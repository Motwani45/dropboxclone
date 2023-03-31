

import 'package:dropboxclone/core/extension/fileenumextension.dart';
import 'package:dropboxclone/feature/bloc/file_management/remote/remote_cubit.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/file_management/remote/remote_state.dart';
class FileListTile extends StatelessWidget {
  final FileEntity file;
  final bool hasInternet;
  final String userId;
  const FileListTile({required this.file,required this.userId,required this.hasInternet,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(hasInternet){
      context.read<RemoteCubit>().startUpload(userId: userId, fileName: file.fileName, filePath: file.filePath);
    }
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 0.0, horizontal: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 70,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                color: file.syncStatus.getFileEnum().colorData,
                width: 70,
                height: 70,
                child:file.syncStatus.getFileEnum().iconData,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(file.fileName),
                    Text(file.fileSize,
                        style: TextStyle(color: Colors.grey))
                  ],
                ),
              ),
              BlocBuilder<RemoteCubit,RemoteState>(builder:(context,state){
                if(state is RemoteStateUploadInProgress) {
                  return Expanded(
                    child: Column(
                      children: [
                        CircularProgressIndicator(value: state.percentage/100,),
                        Text(state.percentage.toString())
                      ],
                    ),
                  );
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
