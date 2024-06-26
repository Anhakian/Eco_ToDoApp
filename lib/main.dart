import 'package:eco_to_do_app/auth/auth.dart';
import 'package:eco_to_do_app/auth/login_or_register.dart';
import 'package:eco_to_do_app/firebase_options.dart';
import 'package:eco_to_do_app/pages/add_task_page.dart';
import 'package:eco_to_do_app/pages/home_page.dart';
import 'package:eco_to_do_app/pages/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          primaryColor: Colors.lightBlue[100],
        ),
        home: const AuthPage(),
        routes: {
          '/login_register_page': (context) => const LoginOrRegister(),
          '/home_page': (context) => const HomePage(),
          '/profile_page': (context) => ProfilePage(),
          '/add_task_page': (context) => AddTaskPage(),
        });
  }
}
