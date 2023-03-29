import 'package:dropboxclone/feature/domain/repository/auth/auth_repository.dart';

class IsTokenValidUsecase{
  final AuthRepository authRepository;
  const IsTokenValidUsecase(this.authRepository);
  Future<bool> call()async{
    return await authRepository.isValidToken();
  }
}