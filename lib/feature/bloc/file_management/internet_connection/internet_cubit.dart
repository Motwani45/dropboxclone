import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropboxclone/feature/bloc/file_management/internet_connection/internet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetCubit extends Cubit<InternetState>{
  InternetCubit():super(InternetStateInitialState()){
    Connectivity().onConnectivityChanged.listen((event) async{
      var internetConnection=await InternetConnectionChecker().hasConnection;
      if(internetConnection){
        emit(InternetStateOnConnected());
      }
      else{
        emit(InternetStateNotConnected());
      }
    });
  }

  void getInitialState() async{
    var internetConnection=await InternetConnectionChecker().hasConnection;
    if(internetConnection){
      emit(InternetStateOnConnected());
    }
    else{
      emit(InternetStateNotConnected());
    }
  }

}