import 'package:dropboxclone/bloc/auth/auth_bloc.dart';
import 'package:dropboxclone/bloc/auth/auth_event.dart';
import 'package:dropboxclone/bloc/auth/auth_state.dart';
import 'package:dropboxclone/common_utils/loading/loading_screen.dart';
import 'package:dropboxclone/utils/auth/dialogs/show_auth_dialog.dart';
import 'package:dropboxclone/views/auth/login_view.dart';
import 'package:dropboxclone/views/auth/register_view.dart';
import 'package:dropboxclone/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_)=>AuthBloc()..add(AuthEventInitialize()),
      child: MaterialApp(
        title: 'DropBox Clone',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocConsumer<AuthBloc,AuthState>(
            builder: (context,state) {
          if(state is AuthStateLoggedOut){
            return LoginView();
          }
          else if(state is AuthStateIsInRegistrationView){
            return RegisterView();
          }
          else if(state is AuthStateLoggedIn){
            return HomePage(userId: state.userId,);
          }
          else{
            return Container();
          }

        }, listener: (context,state){
          if(state.isLoading){
            LoadingScreen.instance().show(context: context, text: "Loading");
          }
          else{
            LoadingScreen.instance().hide();
          }
          final authError=state.authError;
          if(authError!=null){
            showAuthErrorDialog(context, authError);
          }

        }),
      ),
    );
  }
}