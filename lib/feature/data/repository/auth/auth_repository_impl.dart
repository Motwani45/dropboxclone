import 'package:dropboxclone/core/error/auth/auth_error.dart';
import 'package:dropboxclone/feature/data/datasources/auth/auth_datasource.dart';
import 'package:dropboxclone/feature/domain/entity/auth/auth_entity.dart';
import 'package:dropboxclone/feature/domain/repository/auth/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


class AuthRepositoryImpl implements AuthRepository{
  final AuthDataSource authDataSource;
  const AuthRepositoryImpl({
    required this.authDataSource,
  });

  @override
  Future<bool> isValidToken() async{
    return await authDataSource.isValidToken();
  }

  @override
  Future<Either<AuthError, AuthEntity>> signIn(
      String emailAddress, String password) async {
    return await authDataSource.signIn(emailAddress, password);
  }

  @override
  Future<Either<AuthError, AuthEntity>> signUp(
      String emailAddress, String password) async {
    return await authDataSource.signUp(emailAddress, password);
  }
}