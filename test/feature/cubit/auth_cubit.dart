import 'package:bloc_test/bloc_test.dart';
import 'package:dropboxclone/feature/bloc/auth/auth_cubit.dart';
import 'package:dropboxclone/feature/bloc/auth/auth_state.dart';
import 'package:dropboxclone/feature/domain/entity/auth/auth_entity.dart';
import 'package:dropboxclone/feature/domain/usecase/auth/signin_usecase.dart';
import 'package:dropboxclone/feature/domain/usecase/auth/signup_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
class MockSignInUsecase extends Mock implements SignInUsecase {}

class MockSignUpUsecase extends Mock implements SignUpUsecase {}

void main() {
  late MockSignInUsecase signInUsecase;
  late MockSignUpUsecase signUpUsecase;
  setUp(() {
    signUpUsecase = MockSignUpUsecase();
    signInUsecase = MockSignInUsecase();
  });

  group("Auth Cubit Tests", () {
    blocTest(
      "Auth Cubit Go To Registration",
      build: () {
        return
            AuthCubit(
                 signInUsecase: signInUsecase, signUpUsecase: signUpUsecase
            );
          // AuthCubit(
          //   signInUsecase: signInUsecase, signUpUsecase: signUpUsecase);
      },
      act: (authCubit) {
        authCubit.goToRegistration();
      },
      expect: () {
        return [isA<AuthStateIsInRegistrationView>()];
      },
    );

    blocTest("Auth Cubit SignIn call", build: () {
      when(() {
        return signInUsecase.call("dummy", "123456");
      }).thenAnswer((invocation) async {
        return Either.right(AuthEntity(
            token: "Jai",
            expiryDate: DateTime.now(),
            userId: "userId",
            emailAddress: "emailAddress",
            password: "password"));
      });
      return AuthCubit(
          signUpUsecase: signUpUsecase, signInUsecase: signInUsecase);
    }, act: (authCubit) {
      authCubit.signIn("dummy", "123456");
    }, expect: () {
      return [
        isA<AuthStateLoggedOut>(),
        isA<AuthStateLoggedIn>(),
      ];
    });
  });
}
