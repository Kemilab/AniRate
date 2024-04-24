// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextFiled extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextFiled({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: TextStyle(
            color: Color.fromRGBO(255, 80, 61, 1)), //(228, 131, 41, 1)
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: const Color.fromARGB(0, 255, 255, 255)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 207, 94, 18)),
            ),
            fillColor: Color.fromARGB(230, 36, 33, 33),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Color.fromRGBO(255, 80, 61, 1))),
      ),
    );
  }
}
