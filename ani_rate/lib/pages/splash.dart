import 'package:ani_rate/pages/home.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset('assets/logo2.png'),
          const Text(
            "AniRate",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          )
        ],
      ),
      splashTransition: SplashTransition.scaleTransition,
      splashIconSize: 150,
      duration: 1000,
      nextScreen: const MyHomeScreen(),
      pageTransitionType: PageTransitionsType,
    );
  }
}
