
import 'package:dropboxclone/core/error/file_management/file_management_error.dart';
import 'package:dropboxclone/core/utils/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showDuplicateErrorDialog(
    BuildContext context,
    FileManagementError error
    ){
  return showGenericDialog<void>(context: context, title: "Duplicate Files", content: error.message, optionsBuilder: (){
    return {
      'OK':true
    };
  });
}