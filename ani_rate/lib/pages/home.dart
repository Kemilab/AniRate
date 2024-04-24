import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomeScreen extends StatelessWidget {
  MyHomeScreen({super.key});
  final user = FirebaseAuth.instance.currentUser!;
  //sign user out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],
      ),
      body: const Center(child: Text("Logged IN!")),
    );
  }
}
