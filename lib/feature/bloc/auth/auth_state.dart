import 'package:dropboxclone/core/error/auth/auth_error.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/foundation.dart' show immutable;


@immutable
abstract class AuthState {
  final bool isLoading;
  final AuthError? authError;

  const AuthState({
    required this.isLoading,
    required this.authError,
  });
}

@immutable
class AuthStateLoggedIn extends AuthState{
  final String? userId;
  const AuthStateLoggedIn({
    this.userId,
    required super.isLoading,
    required super.authError,
  });



  @override
  String toString() {
    return "AuthStateLoggedIn, ";
  }

}

@immutable
class AuthStateLoggedOut extends AuthState {
  const AuthStateLoggedOut({required super.isLoading, required super.authError});
}

@immutable
class AuthStateIsInRegistrationView extends AuthState{
  AuthStateIsInRegistrationView({required super.isLoading, required super.authError});
}
