import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      body: Stack(
        children: [
          Positioned(
              top: 5.0, // Top position set to 0.0
              left: 0.0, // Left position set to 0.0
              right: 0.0, // Right position set to 0.0 (stretch to full width)
              height: 18.0, // Adjust height as needed
              child: Center(
                child: Text(
                  "Account",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  )),
                ),
              )),
          Positioned(
            top: 80.0,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  margin: EdgeInsets.only(top: 5, left: 25, right: 25),
                  padding: EdgeInsets.all(25),
                  child: const Row(
                    children: [],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
