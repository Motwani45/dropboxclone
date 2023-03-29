import 'package:dropboxclone/core/error/auth/auth_exception.dart';
import 'package:flutter/foundation.dart' show immutable;

const Map<String, AuthError> authorErrorMapping = {
  'EMAIL_NOT_FOUND': AuthErrorUserNotFound(),
  'INVALID_PASSWORD': AuthErrorInvalidPassword(),
  'EMAIL_EXISTS': AuthErrorEmailAlreadyInUse(),
  'SESSION_EXPIRES': AuthErrorRequiresRecentLogin(),
  'INVALID_EMAIL':AuthErrorInvalidEmail()
};

@immutable
abstract class AuthError {
  final String dialogTitle;
  final String dialogText;

  const AuthError({
    required this.dialogTitle,
    required this.dialogText,
  });

  factory AuthError.from(AuthException exception) {
    return authorErrorMapping[exception.code.trim()] ??
        AuthErrorUnknown();
  }
}

@immutable
class AuthErrorUnknown extends AuthError {
  const AuthErrorUnknown()
      : super(
      dialogTitle: 'Authentication Error',
      dialogText: 'Unknown Authentication Error');
}


@immutable
class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin()
      : super(
      dialogTitle: 'Requires Recent Login',
      dialogText:
      'Your Session Completed! Please Log in again');
}


@immutable
class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound()
      : super(
    dialogTitle: 'User Not Found',
    dialogText: 'Either you have written wrong email address or given user was not found on server!',
  );
}



@immutable
class AuthErrorEmailAlreadyInUse extends AuthError {
  const AuthErrorEmailAlreadyInUse()
      : super(
    dialogTitle: 'Email Already In Use',
    dialogText: 'Please choose another email to register with!',
  );
}

@immutable
class AuthErrorInvalidPassword extends AuthError{
  const AuthErrorInvalidPassword():super(dialogText: "You have entered a wrong password",
  dialogTitle: "Invalid Password");
}@immutable
class AuthErrorInvalidEmail extends AuthError{
  const AuthErrorInvalidEmail():super(dialogText: "You have entered a wrong email",
  dialogTitle: "Invalid Email");
}