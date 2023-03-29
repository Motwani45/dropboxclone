import 'package:dropboxclone/feature/domain/entity/auth/auth_entity.dart';

class AuthModel extends AuthEntity{
  final String? token;
  final DateTime? expiryDate;
  final String? userId;
  final String emailAddress;
  final String password;

  const AuthModel({
    required this.token,
    required this.expiryDate,
    required this.userId,
    required this.emailAddress,
    required this.password,
  }) : super(token:token, expiryDate: expiryDate, userId: userId, emailAddress: emailAddress, password:password);
}