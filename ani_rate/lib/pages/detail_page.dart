import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0.0, // Top position set to 0.0
              left: 0.0, // Left position set to 0.0
              right: 0.0, // Right position set to 0.0 (stretch to full width)
              height: 200.0, // Adjust height as needed
              child: SvgPicture.asset(
                'assets/aot_spotlight.svg',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
