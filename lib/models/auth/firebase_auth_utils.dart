import 'dart:async';
import 'dart:convert';
import 'package:dropboxclone/errors/auth/auth_exception.dart';
import 'package:dropboxclone/utils/auth/constants/web_api_key.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class FirebaseAuthUtils {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;
  bool get isAuth{
    return token!=null;
  }
  String? get token{
    if(_expiryDate!=null&&_expiryDate!.isAfter(DateTime.now())&&_token!=null){
      return _token!;
    }
    return null;
  }
  String get userId{
    if(_userId==null){
      return '';
    }
    return _userId!;
  }
  Future<String> _authenticate(String email, String password,
      String segment) async {
    final url =
    Uri.parse(
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
      print(responseData);
      if (responseData['error'] != null) {
        throw AuthException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
          Duration(seconds: int.parse(responseData['expiresIn'])));
      print("User Authenticate");
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String()
      });
      prefs.setString('userData', userData);
    }
    catch (error) {
      throw error;
    }
    return _userId!;
  }

  Future<String> signup(String email, String password) async {
    return
      _authenticate(email, password, 'signUp');
  }

  Future<String> signin(String email, String password) async {
    return
      _authenticate(email, password, 'signInWithPassword');
  }

}