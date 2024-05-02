import 'package:ani_rate/pages/auth_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/logo.png",
              height: 200.0,
              width: 200.0,
            ),
            Image.asset(
              "assets/title.png",
              height: 200.0,
              width: 300.0,
            ),
            /*const Text(
              "AniRate",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            )*/
          ],
        ),
      ),
      splashIconSize: 350,
      duration: 1000,
      nextScreen: AuthPage(),
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(milliseconds: 1000),
      backgroundColor: Color.fromARGB(207, 0, 0, 0),
    );
  }
}
