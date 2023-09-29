import 'package:flutter/material.dart';

class WidgetTextField extends StatelessWidget {
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType type;
  final String hintText;

  const WidgetTextField({super.key,
    required this.obscureText,
    required this.controller,
    required this.type,
    required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 8, bottom: 8, left: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.white.withOpacity(0.8),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14)),
      ),
    );
  }
}
