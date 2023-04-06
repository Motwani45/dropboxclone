import 'package:dropboxclone/feature/domain/entity/auth/auth_entity.dart';

class AuthModel extends AuthEntity{
  const AuthModel({
    required super.token,
    required super.expiryDate,
    required super.userId,
    required super.emailAddress,
    required super.password,
  }) ;
}