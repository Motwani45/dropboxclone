import 'package:dropboxclone/core/enums/file_enum.dart';

extension FileEnumExtension on String{
  FileEnum getFileEnum(){
    if(this=="Not Uploaded"){
      return FileEnum.NotUploaded;
    }
    if(this=="Upload In Progress"){
      return FileEnum.UploadInProgress;
    }
    if(this=="Upload Complete"){
      return FileEnum.UploadComplete;
    }
    return FileEnum.UploadFailed;
  }
}