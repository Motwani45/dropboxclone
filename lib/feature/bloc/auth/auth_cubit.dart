
import 'package:dropboxclone/feature/bloc/auth/auth_state.dart';
import 'package:dropboxclone/feature/data/datasources/auth/auth_datasource_impl.dart';
import 'package:dropboxclone/feature/data/repository/auth/auth_repository_impl.dart';
import 'package:dropboxclone/feature/domain/usecase/auth/signin_usecase.dart';
import 'package:dropboxclone/feature/domain/usecase/auth/signup_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthCubit extends Cubit<AuthState>{
AuthCubit():super(const AuthStateLoggedOut(isLoading: false, authError: null));
final SignInUsecase signInUsecase=SignInUsecase(
  AuthRepositoryImpl(
    authDataSource: AuthDataSourceImpl(),
  ),
);

final SignUpUsecase signUpUsecase=SignUpUsecase(
  AuthRepositoryImpl(
    authDataSource: AuthDataSourceImpl(),
  ),
);


void signIn(String emailAddress,String password) async{
  emit(const AuthStateLoggedOut(isLoading: true, authError: null));
    final resultType = await signInUsecase.call(emailAddress, password);
    resultType.fold((authError) {
      emit(AuthStateLoggedOut(isLoading: false, authError: authError));
    }, (authEntity) {
      emit(AuthStateLoggedIn(userId:authEntity.userId,isLoading: false, authError: null));
    });
}

void signUp(String emailAddress,String password) async{
  emit(const AuthStateIsInRegistrationView(isLoading: true, authError: null));
    final resultType = await signUpUsecase.call(emailAddress, password);
  resultType.fold((authError) {
    emit(AuthStateIsInRegistrationView(isLoading: false, authError: authError));
  }, (authEntity) {
    emit(AuthStateLoggedIn(userId:authEntity.userId,isLoading: false, authError: null));
  });
}

void goToLogin(){
  emit(const AuthStateLoggedOut(isLoading: false, authError: null));
}
void goToRegistration(){
  emit(
        const AuthStateIsInRegistrationView(isLoading: false, authError: null));
  }

}