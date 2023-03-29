import 'package:dropboxclone/feature/domain/repository/auth/auth_repository.dart';

class GetCurrentUseridUsecase {
  final AuthRepository repository;

  GetCurrentUseridUsecase({required this.repository});

  Future<String> call()async{
    return await repository.getCurrentUserId();
  }
}