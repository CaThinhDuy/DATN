// lib/widgets/custom_text_field.dart
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String labelText;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.labelText,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(icon),
        labelText: labelText,
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
    );
  }
}
