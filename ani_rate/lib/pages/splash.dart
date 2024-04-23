import 'package:ani_rate/pages/login_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            SvgPicture.asset(
              "assets/logo.svg",
              height: 150.0,
              width: 150.0,
            ),
            Image.asset(
              "assets/title.png",
              height: 150.0,
              width: 150.0,
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
      nextScreen: LoginPage(),
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(milliseconds: 1000),
      backgroundColor: Color.fromARGB(221, 87, 187, 6),
    );
  }
}
