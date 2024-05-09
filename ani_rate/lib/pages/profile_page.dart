import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool resetPasswordSuccess = false;

  void resetPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: currentUser.email!);
    setState(() {
      resetPasswordSuccess = true;
    });
  }

  void deleteUser() async {
    //await currentUser.delete();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      body: Stack(
        children: [
          Positioned(
              top: 10.0, // Top position set to 0.0
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
            top: 50.0,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: ListView(
              children: [
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(176, 63, 61, 61),
                      borderRadius: BorderRadius.circular(8)),
                  margin: const EdgeInsets.only(top: 5, left: 25, right: 25),
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://www.woolha.com/media/2020/03/eevee.png"),
                                fit: BoxFit.fill)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          currentUser.email!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            color: Color.fromARGB(255, 82, 81, 81),
                            fontWeight: FontWeight.w700,
                          )),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: resetPassword,
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(176, 63, 61, 61),
                        borderRadius: BorderRadius.circular(8)),
                    margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Reset Password",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: resetPasswordSuccess
                                  ? const Color.fromARGB(255, 94, 255, 0)
                                  : const Color.fromARGB(255, 255, 0, 0),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: deleteUser,
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(176, 63, 61, 61),
                        borderRadius: BorderRadius.circular(8)),
                    margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Remove account",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
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
