import 'dart:convert';

import 'package:dropboxclone/core/constants/web_apikey.dart';
import 'package:dropboxclone/core/error/auth/auth_error.dart';
import 'package:dropboxclone/core/error/auth/auth_exception.dart';
import 'package:dropboxclone/feature/data/datasources/auth/auth_datasource.dart';
import 'package:dropboxclone/feature/data/models/auth/auth_model.dart';
import 'package:dropboxclone/feature/domain/entity/auth/auth_entity.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthDataSourceImpl implements AuthDataSource {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  @override
  Future<bool> isValidToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData=json.decode(prefs.getString('userData')!) as Map<String,Object>;
    final expiryDate=DateTime.parse(extractedUserData['expiryDate'] as String);
    if(expiryDate.isBefore(DateTime.now())){
      return false;
    }
    _token=extractedUserData['token'] as String;
    _userId=extractedUserData['userId'] as String;
    _expiryDate=expiryDate;
    return true;
  }

  @override
  Future<Either<AuthError, AuthEntity>> signIn(AuthEntity user) async {
    return await authenticate(
        user.emailAddress, user.password, "signInWithPassword");
  }

  @override
  Future<Either<AuthError, AuthEntity>> signUp(AuthEntity user) async {
    return await authenticate(user.emailAddress, user.password, 'signUp');
  }


  Future<Either<AuthError, AuthEntity>> authenticate(
      String email, String password, String segment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$segment?key=$webApiKey');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        return Either<AuthError, AuthEntity>.left(
            AuthError.from(AuthException(responseData['error']['message'])));
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      print("User Authenticate");
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String()
      });
      prefs.setString('userData', userData);
    } catch (error) {
      return Either<AuthError, AuthEntity>.left(AuthErrorUnknown());
    }
    return Either<AuthError, AuthEntity>.of(AuthModel(
        token: _token,
        expiryDate: _expiryDate,
        userId: _userId,
        emailAddress: email,
        password: password));
  }
}
