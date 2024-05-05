import 'package:ani_rate/pages/home.dart';
import 'package:ani_rate/pages/login_or_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user logged in
          if (snapshot.hasData) {
            return MyHomeScreen();
          }
          //user not logged in
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
