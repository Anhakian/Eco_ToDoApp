import "package:eco_to_do_app/auth/login_or_register.dart";
import "package:eco_to_do_app/pages/home_page.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If user is logged in
        if (snapshot.hasData) {
          return const HomePage();
        }
        // If user is not logged in
        else {
          return const LoginOrRegister();
        }
      },
    ));
  }
}
