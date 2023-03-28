import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent{
  const AuthEvent();
}

@immutable
class AuthEventLogOut implements AuthEvent{
  const AuthEventLogOut();
}
@immutable
class AuthEventInitialize implements AuthEvent{
  const AuthEventInitialize();
}
@immutable
class AuthEventLogIn implements AuthEvent{
  final String email;
  final String password;
  const AuthEventLogIn({
    required this.email,
    required this.password,
  });
}
@immutable
class AuthEventGotToRegistration implements AuthEvent{
  const AuthEventGotToRegistration();
}
@immutable
class AuthEventGotToLogin implements AuthEvent{
  const AuthEventGotToLogin();
}
@immutable
class AuthEventRegister implements AuthEvent{
  final String email;
  final String password;
  const AuthEventRegister({
    required this.email,
    required this.password,
  });
}