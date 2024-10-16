import 'package:db_bloc/bloc/bloc/user_bloc.dart';
import 'package:db_bloc/bloc/event/user_event.dart';
import 'package:db_bloc/util/helpers.dart';
import 'package:db_bloc/widget/custom_elevated_button.dart';
import 'package:db_bloc/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/state/user_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 4,
        title: const Text('Login Screen'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body: BlocListener<UserBloc, UserState>(
        listenWhen: (previous, current) =>
            current is UserProcessState &&
            current.type == UserProcessType.login,
        listener: (context, state) {
          state as UserProcessState;
          if (state.status) {
            Navigator.pushReplacementNamed(context, '/notes_screen');
          }
          showSnackBar(
              context: context, message: state.message, error: !state.status);
        },
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsetsDirectional.all(20),
          children: [
            const Text(
              'Login Screen',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 26),
            ),
            const Text(
              'Welcome back ................',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.black54,
                  fontSize: 18),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: emailController,
              hintText: 'add email',
              icon: Icons.email_outlined,
              maxLength: 50,
              helperText: 'example@email.com',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: passwordController,
              hintText: 'password',
              icon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/register_screen'),
                child: const Text(
                  'create new Account...',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )),
            const SizedBox(height: 20),
            CustomElevatedButton(onPress: () => performLogin(), title: 'login'),
          ],
        ),
      ),
    );
  }

  void performLogin() {
    if (checkData()) {
      login();
    }
  }

  bool checkData() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, message: 'Enter Your Data', error: true);
    return false;
  }

  void login() {
    BlocProvider.of<UserBloc>(context)
        .add(LoginEvent(emailController.text, passwordController.text));
  }
}
