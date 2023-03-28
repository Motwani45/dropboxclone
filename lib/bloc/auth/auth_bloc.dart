import 'dart:convert';
import 'dart:io';


import 'package:dropboxclone/bloc/auth/auth_event.dart';
import 'package:dropboxclone/bloc/auth/auth_state.dart';
import 'package:dropboxclone/errors/auth/auth_error.dart';
import 'package:dropboxclone/errors/auth/auth_exception.dart';
import 'package:dropboxclone/models/auth/firebase_auth_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(const AuthStateLoggedOut(isLoading: false, authError: null)) {
    // handle uploading images
    on<AuthEventLogOut>((event,emit) async{
      emit(AuthStateLoggedOut(isLoading: true, authError: null));
      await FirebaseAuth.instance.signOut();
      emit(AuthStateLoggedOut(isLoading: false,authError: null));
    });
    on<AuthEventInitialize>((event,emit) async{
      String? userId;
      final prefs=await SharedPreferences.getInstance();
      if(prefs.containsKey('userData')){
        final extractedUserData=json.decode(prefs.getString('userData')!) as Map<String,dynamic>;
        userId=extractedUserData['userId'] as String;
      }
      if(userId!=null){
        emit(AuthStateLoggedIn(userId: userId, isLoading: false, authError: null));
      }
      else{
        emit(AuthStateLoggedOut(isLoading: false, authError: null));
      }
    });
    on<AuthEventGotToRegistration>((event,emit){
      emit(AuthStateIsInRegistrationView(isLoading: false, authError: null));
    });
    on<AuthEventGotToLogin>((event,emit){
      emit(AuthStateLoggedOut(isLoading: false, authError: null));
    });
    on<AuthEventRegister>((event,emit)async{
      emit(AuthStateIsInRegistrationView(isLoading: true, authError: null));
      final email=event.email;
      final password=event.password;
      try{
        final userId=await FirebaseAuthUtils().signup(email, password);
        emit(AuthStateLoggedIn(userId: userId,  isLoading: false, authError: null));
      } on AuthException catch(e){
        emit(AuthStateIsInRegistrationView(isLoading: false, authError: AuthError.from(e)));
      }
    });
    on<AuthEventLogIn>((event,emit) async{
      emit(AuthStateLoggedOut(isLoading: true, authError: null));
      final email=event.email;
      final password=event.password;
      try{
        final userId= await FirebaseAuthUtils().signin(email, password);
        emit(AuthStateLoggedIn(userId: userId,  isLoading: false, authError: null));
      } on AuthException catch(e){
        emit(AuthStateLoggedOut(isLoading: false, authError: AuthError.from(e)));
      }
    });
  }

  Future<Iterable<Reference>> _getImages(String userId) {
    return FirebaseStorage.instance
        .ref(userId)
        .list()
        .then((listResult) => listResult.items);
  }
}