import 'package:dropboxclone/core/error/auth/auth_error.dart';
import 'package:dropboxclone/feature/data/datasources/auth/auth_datasource.dart';
import 'package:dropboxclone/feature/data/datasources/auth/auth_datasource_impl.dart';
import 'package:dropboxclone/feature/domain/entity/auth/auth_entity.dart';
import 'package:dropboxclone/feature/domain/repository/auth/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthDataSource authDataSource;
  const AuthRepositoryImpl({
    required this.authDataSource,
  });
  @override
  Future<String> getCurrentUserId()async{
    return await authDataSource.getCurrentUserId();
  }

  @override
  Future<bool> isValidToken() async{
    return await authDataSource.isValidToken();
  }

  @override
  Future<Either<AuthError, AuthEntity>> signIn(AuthEntity user) async{
    return await authDataSource.signIn(user);
  }

  @override
  Future<void> signOut() async{
  }

  @override
  Future<Either<AuthError, AuthEntity>> signUp(AuthEntity user) async{
return await authDataSource.signUp(user);
  }

}