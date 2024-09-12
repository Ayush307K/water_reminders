import 'package:flutter/material.dart';

// Custom Text Field Widget
class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;

  CustomTextField({
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
    );
  }
}
