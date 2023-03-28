import 'package:dropboxclone/common_utils/dialogs/generic_dialog.dart';
import 'package:dropboxclone/errors/auth/auth_error.dart';

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