import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(0, 255, 255, 255)),
          borderRadius: BorderRadius.circular(16),
          color: Color.fromARGB(226, 255, 255, 255)),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
