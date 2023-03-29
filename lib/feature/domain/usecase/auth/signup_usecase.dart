import 'package:dropboxclone/core/error/auth/auth_error.dart';
import 'package:dropboxclone/feature/domain/entity/auth/auth_entity.dart';
import 'package:dropboxclone/feature/domain/repository/auth/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignUpUsecase{
  final AuthRepository authRepository;
  const SignUpUsecase(this.authRepository);
  Future<Either<AuthError,AuthEntity>> call(AuthEntity entity)async{
    return await authRepository.signUp(entity);
  }
}