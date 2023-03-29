import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable{
  final String? token;
  final DateTime? expiryDate;
  final String? userId;
  final String emailAddress;
  final String password;

  @override
  List<Object?> get props => [token,expiryDate,userId,emailAddress,password];

  const AuthEntity({
    required this.token,
    required this.expiryDate,
    required this.userId,
    required this.emailAddress,
    required this.password,
  });
}