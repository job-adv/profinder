import 'package:flutter/material.dart';

class RoundedTextArea extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final bool? obscured;
  final IconData? icon;
  final String? Function(String?)? validator; // Validator function

  const RoundedTextArea({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.obscured,
    this.icon,
    this.validator, // Include validator parameter
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
      child: Container(
        height: 200, // Set the height of the text area
        child: TextFormField(
          // Changed to TextFormField to enable validation
          maxLines: null, // Allow unlimited lines of text
          keyboardType: TextInputType.multiline, // Enable multiline input
          obscureText: obscured ?? false,
          controller: controller,
          onChanged: onChanged,
          validator: validator, // Validator function
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            border: InputBorder.none, // Hide the border of the TextField
            prefixIcon: icon != null ? Icon(icon) : null,
          ),
        ),
      ),
    );
  }
}
