import 'package:db_bloc/bloc/bloc/note_bloc.dart';
import 'package:db_bloc/bloc/bloc/user_bloc.dart';
import 'package:db_bloc/bloc/state/note_state.dart';
import 'package:db_bloc/bloc/state/user_state.dart';
import 'package:db_bloc/db/db_controller.dart';
import 'package:db_bloc/screen/launch_screen.dart';
import 'package:db_bloc/storge/pref_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screen/app/notes_screen.dart';
import 'screen/auth/login_screen.dart';
import 'screen/auth/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbController().initDatabase();
  await SharedPrefController().initPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotesBloc>(create: (context) => NotesBloc(LoadingState())),
        BlocProvider<UserBloc>(
            create: (context) => UserBloc(DefaultUserState()))
      ],
      child: const MyMaterial(),
    );
  }
}

class MyMaterial extends StatelessWidget {
  const MyMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/lunch_screen',
      routes: {
        '/lunch_screen': (context) => const LaunchScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/notes_screen': (context) => const NotesScreen(),
        '/register_screen': (context) => const RegisterScreen(),
      },
    );
  }
}
