class AuthEntity {
  final String? token;
  final DateTime? expiryDate;
  final String? userId;
  final String emailAddress;
  final String password;

  const AuthEntity({
    required this.token,
    required this.expiryDate,
    required this.userId,
    required this.emailAddress,
    required this.password,
  });
}