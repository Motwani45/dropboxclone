import 'package:dropboxclone/core/pages/home_page.dart';
import 'package:dropboxclone/core/utils/loading/loading_screen.dart';
import 'package:dropboxclone/feature/bloc/auth/auth_cubit.dart';
import 'package:dropboxclone/feature/bloc/auth/auth_state.dart';
import 'package:dropboxclone/feature/presentation/pages/auth/login_view.dart';
import 'package:dropboxclone/feature/presentation/pages/auth/register_view.dart';
import 'package:dropboxclone/feature/presentation/widgets/error_dialog/auth_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(
      )..goToLogin(),
      child: MaterialApp(
        title: 'DropBox Clone',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
          if (state is AuthStateLoggedOut) {
            return LoginView();
          } else if (state is AuthStateIsInRegistrationView) {
            return RegisterView();
          } else if (state is AuthStateLoggedIn) {
            return const HomePage();
          } else {
            return Container();
          }
        }, listener: (context, state) {
          if (state.isLoading) {
            LoadingScreen.instance().show(context: context, text: "Loading");
          } else {
            LoadingScreen.instance().hide();
          }
          final authError = state.authError;
          if (authError != null) {
            showAuthErrorDialog(context, authError);
          }
        }),
      ),
    );
  }
}