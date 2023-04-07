
import 'package:dropboxclone/feature/bloc/auth/auth_state.dart';
import 'package:dropboxclone/feature/domain/usecase/auth/signin_usecase.dart';
import 'package:dropboxclone/feature/domain/usecase/auth/signup_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthCubit extends Cubit<AuthState>{
  final SignInUsecase signInUsecase;
  final SignUpUsecase signUpUsecase;
AuthCubit({
    required this.signUpUsecase,
  required this.signInUsecase
}):super(const AuthStateLoggedOut(isLoading: false, authError: null));


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
      const AuthStateIsInRegistrationView(isLoading: false, authError: null),
    );
  }

}