import 'package:dropboxclone/core/enums/file_enum.dart';

extension FileEnumExtension on String{
  FileEnum getFileEnum(){
    if(this=="NotUploaded"){
      return FileEnum.NotUploaded;
    }
    if(this=="UploadInProgress"){
      return FileEnum.UploadInProgress;
    }
    if(this=="UploadComplete"){
      return FileEnum.UploadComplete;
    }
    return FileEnum.UploadFailed;
  }
}