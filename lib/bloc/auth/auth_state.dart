import 'package:dropboxclone/errors/auth/auth_error.dart';
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
  final String userId;
  const AuthStateLoggedIn({
    required this.userId,
    required super.isLoading,
    required super.authError,
  });

  @override
  bool operator ==(other) {
    final otherClass = other;
    if (otherClass is AuthStateLoggedIn) {
      return isLoading == otherClass.isLoading &&
          userId == otherClass.userId;
    } else {
      return false;
    }
  }


  @override
  String toString() {
    return "AuthStateLoggedIn, ";
  }
}

@immutable
class AuthStateLoggedOut extends AuthState {
  const AuthStateLoggedOut({required super.isLoading, required super.authError});
  @override
  String toString() {
    return "AuthStateLoggedOut, isLoading=$isLoading, authError=$authError";
  }
}

@immutable
class AuthStateIsInRegistrationView extends AuthState{
  AuthStateIsInRegistrationView({required super.isLoading, required super.authError});
}

extension GetUser on AuthState{
  String? get userId{
    final cls=this;
    if(cls is AuthStateLoggedIn){
      return cls.userId;
    }
    return null;
  }
}
