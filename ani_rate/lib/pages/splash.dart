import 'package:ani_rate/pages/home.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          SvgPicture.asset(
            "assets/logo.svg",
            // height: 70.0,
            //width: 70.0,
          ),
          SvgPicture.asset(
            "assets/title.svg",
            height: 200.0,
            width: 200.0,
          ),
          /*const Text(
            "AniRate",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          )*/
        ],
      ),
      splashIconSize: 350,
      duration: 1000,
      nextScreen: const MyHomeScreen(),
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(milliseconds: 1000),
      backgroundColor: const Color.fromARGB(221, 179, 247, 52),
    );
  }
}
