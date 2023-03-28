import 'package:dropboxclone/bloc/auth/auth_bloc.dart';
import 'package:dropboxclone/bloc/auth/auth_event.dart';
import 'package:dropboxclone/common_utils/extensions/if_debugging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  final emailController =
  TextEditingController(text: "jai@jai.com".ifDebugging);
  final passwordController =
  TextEditingController(text: "123456".ifDebugging);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
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
              context.read<AuthBloc>().add(AuthEventRegister(email: email, password: password));

            }, child: const Text("Register")),
            TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthEventGotToLogin());
                },
                child: const Text("Already have account? Login")),
          ],
        ),
      ),
    );
  }
}