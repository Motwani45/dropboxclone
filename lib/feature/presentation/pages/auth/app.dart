import 'package:dropboxclone/core/utils/loading/loading_screen.dart';
import 'package:dropboxclone/feature/bloc/auth/auth_cubit.dart';
import 'package:dropboxclone/feature/bloc/auth/auth_state.dart';
import 'package:dropboxclone/feature/bloc/file_management/internet_connection/internet_cubit.dart';
import 'package:dropboxclone/feature/bloc/file_management/local/local_cubit.dart';
import 'package:dropboxclone/feature/bloc/file_management/remote/remote_cubit.dart';
import 'package:dropboxclone/feature/presentation/pages/auth/login_view.dart';
import 'package:dropboxclone/feature/presentation/pages/auth/register_view.dart';
import 'package:dropboxclone/feature/presentation/pages/file_management/home_page.dart';
import 'package:dropboxclone/feature/presentation/widgets/error_dialog/auth_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => sl<AuthCubit>(),
        ),
        BlocProvider<LocalCubit>(create: (_) {
          return sl<LocalCubit>()..getFiles();
        }),
        BlocProvider<InternetCubit>(create: (_){
          return InternetCubit()..getInitialState();
        }),
        BlocProvider<RemoteCubit>(create: (_){
          return sl<RemoteCubit>();
        })
      ],
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
            return HomePage(
              userId: state.userId!,
            );
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
