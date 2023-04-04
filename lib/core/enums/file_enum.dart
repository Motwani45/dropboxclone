import 'package:flutter/material.dart';

enum FileEnum{
  NotUploaded("NotUploaded",Colors.grey),
  UploadInProgress("UploadInProgress",Colors.yellow),
  UploadComplete("UploadComplete",Colors.green),
  UploadFailed("UploadFailed",Colors.red);

  final String message;
  final Color colorData;
  const FileEnum(this.message,this.colorData,);
}