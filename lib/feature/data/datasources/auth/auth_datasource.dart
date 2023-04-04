import 'package:dropboxclone/core/error/auth/auth_error.dart';
import 'package:dropboxclone/feature/domain/entity/auth/auth_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthDataSource{
  Future<bool> isValidToken();

  Future<Either<AuthError, AuthEntity>> signIn(
      String emailAddress, String password);

  Future<Either<AuthError, AuthEntity>> signUp(
      String emailAddress, String password);
}