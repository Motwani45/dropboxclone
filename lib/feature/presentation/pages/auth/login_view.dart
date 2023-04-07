
import 'package:dropboxclone/feature/bloc/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final emailController =
  TextEditingController();
  final passwordController =
  TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration:
              const InputDecoration(hintText: "Enter your email here..."),
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance: Brightness.dark,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: "Enter your password here..."),
              obscureText: true,
            ),
            TextButton(onPressed: () {
              final email=emailController.text;
              final password=passwordController.text;
              context.read<AuthCubit>().signIn(email,password);

            }, child: const Text("Log In")),
            TextButton(
                onPressed: () {
                  context.read<AuthCubit>().goToRegistration();
                },
                child: const Text("Don't have account? Register")),
          ],
        ),
      ),
    );
  }
}