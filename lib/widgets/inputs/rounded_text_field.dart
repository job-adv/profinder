import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final bool? obscured;
  final bool? enabled;
  final IconData? icon;
  final FormFieldValidator<String>? validator;

  const RoundedTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.obscured,
    this.enabled,
    this.icon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey[200],
      ),
      child: TextFormField(
        obscureText: obscured ?? false,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        enabled: enabled ?? true,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          border: InputBorder.none,
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
      ),
    );
  }
}
