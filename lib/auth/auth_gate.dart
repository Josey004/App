import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/adminn/home_admin.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/intro_login_register/intro_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.email == "admin@admin.com") {
              return const HomePage();
            } else {
              return const HomeScreen();
            }
          } else {
            return IntroPage();
          }
        },
      ),
    );
  }
}
