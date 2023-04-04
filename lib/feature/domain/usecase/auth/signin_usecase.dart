import 'package:dropboxclone/feature/domain/entity/auth/auth_entity.dart';
import 'package:dropboxclone/feature/domain/repository/auth/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/auth/auth_error.dart';

class SignInUsecase{
  final AuthRepository authRepository;

  const SignInUsecase(this.authRepository);

  Future<Either<AuthError, AuthEntity>> call(
      String emailAddress, String password) async {
    return await authRepository.signIn(emailAddress, password);
  }
}