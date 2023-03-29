class AuthException implements Exception{
  final String code;
  const AuthException(this.code);
}