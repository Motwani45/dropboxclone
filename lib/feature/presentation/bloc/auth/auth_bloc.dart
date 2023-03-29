import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:dropboxclone/core/error/auth/auth_error.dart';
import 'package:dropboxclone/feature/domain/entity/auth/auth_entity.dart';
import 'package:dropboxclone/feature/domain/usecase/auth/is_token_valid_usecase.dart';
import 'package:dropboxclone/feature/domain/usecase/auth/signin_usecase.dart';
import 'package:dropboxclone/feature/domain/usecase/auth/signup_usecase.dart';
import 'package:dropboxclone/feature/presentation/bloc/auth/auth_event.dart';
import 'package:dropboxclone/feature/presentation/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IsTokenValidUsecase tokenValidUsecase;
  final SignUpUsecase signUpUsecase;
  final SignInUsecase signInUsecase;

  AuthBloc({
    required this.tokenValidUsecase,
    required this.signInUsecase,
    required this.signUpUsecase
  })
      : super(const AuthStateLoggedOut(isLoading: false, authError: null)) {
    on<AuthEventInitialize>((event, emit) async {
      final isValid = await tokenValidUsecase.call();
      if (isValid) {
        emit(AuthStateLoggedIn(isLoading: false, authError: null));
      }
      else {
        emit(AuthStateLoggedOut(isLoading: false, authError: null));
      }
    });
    on<AuthEventGotToRegistration>((event, emit) {
      emit(AuthStateIsInRegistrationView(isLoading: false, authError: null));
    });
    on<AuthEventGotToLogin>((event, emit) {
      emit(AuthStateLoggedOut(isLoading: false, authError: null));
    });
    on<AuthEventRegister>((event, emit) async {
      emit(AuthStateIsInRegistrationView(isLoading: true, authError: null));
      final AuthEntity entity=AuthEntity(token: null, expiryDate: null, userId: null, emailAddress: event.emailAddress, password: event.password);
      final resultType=await signUpUsecase.call(entity);
      AuthError? authError;
      AuthEntity? authEntity;
      resultType.fold((l){
        authError=l;
      }, (r) {
        authEntity=r;
      });
      if(authError!=null){
        emit(AuthStateIsInRegistrationView(isLoading: false, authError: authError!));
      }
      else{
        emit(const AuthStateLoggedIn(isLoading: false, authError: null));
      }

    });
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut(isLoading: true, authError: null));
      final AuthEntity entity=AuthEntity(token: null, expiryDate: null, userId: null, emailAddress: event.emailAddress, password: event.password);
      final resultType=await signInUsecase.call(entity);
      AuthError? authError;
      AuthEntity? authEntity;
      resultType.fold((l){
        authError=l;
      }, (r) {
        authEntity=r;
      });
      if(authError!=null){
        emit(AuthStateLoggedOut(isLoading: false, authError: authError!));
      }
      else{
        emit(const AuthStateLoggedIn(isLoading: false, authError: null));
      }
    }

  );
}

}