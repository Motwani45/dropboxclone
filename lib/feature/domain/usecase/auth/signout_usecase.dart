import 'package:dropboxclone/feature/domain/repository/auth/auth_repository.dart';

class SignOutUsecase{
  final AuthRepository authRepository;
  const SignOutUsecase(this.authRepository);
  Future<void> call()async {
    return await authRepository.signOut();
  }
}