import 'package:dropboxclone/core/error/auth/auth_error.dart';
import 'package:dropboxclone/feature/domain/entity/auth/auth_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthDataSource{
  Future<bool> isValidToken();
  Future<Either<AuthError,AuthEntity>> signIn(AuthEntity user);
  Future<Either<AuthError,AuthEntity>> signUp(AuthEntity user);
  Future<void> signOut();
  Future<String> getCurrentUserId();
}