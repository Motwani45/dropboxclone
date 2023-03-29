import 'package:dropboxclone/core/error/auth/auth_error.dart';
import 'package:dropboxclone/core/utils/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showAuthErrorDialog(
    BuildContext context,
    AuthError error
    ){
  return showGenericDialog<void>(context: context, title: error.dialogTitle, content: error.dialogText, optionsBuilder: (){
    return {
      'OK':true
    };
  });
}