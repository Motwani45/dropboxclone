import 'package:flutter/material.dart';

enum FileEnum{
  NotUploaded("NotUploaded",Colors.grey,Icon(Icons.not_interested)),
  UploadInProgress("UploadInProgress",Colors.yellow,Icon(Icons.timelapse)),
  UploadComplete("UploadComplete",Colors.green,Icon(Icons.emoji_events_sharp)),
  UploadFailed("UploadFailed",Colors.red,Icon(Icons.emoji_flags));

  final String message;
  final Color colorData;
  final Icon iconData;
  const FileEnum(this.message,this.colorData,this.iconData);
}