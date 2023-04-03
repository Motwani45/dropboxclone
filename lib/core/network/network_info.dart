import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<bool> getInternetStatus()async{
  return await InternetConnectionChecker().hasConnection;
}


