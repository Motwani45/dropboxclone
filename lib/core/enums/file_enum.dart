import 'package:flutter/material.dart';

enum FileEnum{
  NotUploaded("Not Uploaded",Colors.grey,Icon(Icons.not_interested)),
  UploadInProgress("Upload In Progress",Colors.yellow,Icon(Icons.timelapse)),
  UploadComplete("Upload Complete",Colors.green,Icon(Icons.emoji_events_sharp)),
  UploadFailed("Upload Failed",Colors.red,Icon(Icons.emoji_flags));

  final String message;
  final Color colorData;
  final Icon iconData;
  const FileEnum(this.message,this.colorData,this.iconData);
}