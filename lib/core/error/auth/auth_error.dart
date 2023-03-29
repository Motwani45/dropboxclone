import 'package:dropboxclone/core/error/auth/auth_exception.dart';
import 'package:flutter/foundation.dart' show immutable;

const Map<String, AuthError> authorErrorMapping = {
  'EMAIL_NOT_FOUND': AuthErrorUserNotFound(),
  'INVALID_PASSWORD': AuthErrorInvalidPassword(),
  'EMAIL_EXISTS': AuthErrorEmailAlreadyInUse(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
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
        AuthErrorUnknown(exception);
  }
}

@immutable
class AuthErrorUnknown extends AuthError {
  final AuthException innerException;
  const AuthErrorUnknown(this.innerException)
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
      'You need to log out and log back in again in order to perform this operation');
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
}