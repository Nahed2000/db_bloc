import 'package:db_bloc/bloc/event/user_event.dart';
import 'package:db_bloc/model/user.dart';
import 'package:db_bloc/util/helpers.dart';
import 'package:db_bloc/widget/custom_elevated_button.dart';
import 'package:db_bloc/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc/user_bloc.dart';
import '../../bloc/state/user_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 4,
        title: const Text('Register Screen'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body: BlocListener<UserBloc, UserState>(
        listenWhen: (previous, current) =>
            current is UserProcessState &&
            current.type == UserProcessType.create,
        listener: (context, state) {
          state as UserProcessState;
          if (state.status && state.type == UserProcessType.create) {
            Navigator.pop(context);
          }
          showSnackBar(
              context: context, message: state.message, error: !state.status);
        },
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsetsDirectional.all(20),
          children: [
            const Text(
              'Register Screen',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 26),
            ),
            const Text(
              'Create Account ................',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.black54,
                  fontSize: 18),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: nameController,
              hintText: 'your Name',
              icon: Icons.person_2_outlined,
              maxLength: 50,
              helperText: 'Ahmed Nahed',
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
            CustomElevatedButton(
                onPress: () => performRegister(), title: 'register'),
          ],
        ),
      ),
    );
  }

  void performRegister() {
    if (checkData()) {
      register();
    }
  }

  bool checkData() {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        nameController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, message: 'Enter Your Data', error: true);
    return false;
  }

  void register() {
    BlocProvider.of<UserBloc>(context).add(CreateEvent(user));
  }

  User get user {
    User user = User();
    user.password = passwordController.text;
    user.name = nameController.text;
    user.email = emailController.text;
    return user;
  }
}
