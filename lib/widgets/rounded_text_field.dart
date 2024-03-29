import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final bool? obscured;
  final IconData? icon;

  const RoundedTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.obscured,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey[200], // Adjust background color as needed
      ),
      child: TextField(
        obscureText: obscured ?? false,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          border: InputBorder.none, // Hide the border of the TextField
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
      ),
    );
  }
}
