import 'dart:collection';
import 'package:dropboxclone/core/enums/file_enum.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_entity.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/local/file_list_entity.dart';

class QueueSingleton{
  final Queue<FileEntity> queue=Queue();
  QueueSingleton._internal();
  static final _instance=QueueSingleton._internal();
  factory QueueSingleton(){
    return _instance;
  }

  Queue getQueue(FileListEntity entity){
    queue.clear();
    for (var element in entity) {
      if(element.syncStatus==FileEnum.UploadFailed.message||element.syncStatus==FileEnum.NotUploaded.message){
        queue.addFirst(element);
      }
    }
    return queue;
  }
}