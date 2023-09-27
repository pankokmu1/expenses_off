import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ETextField extends StatelessWidget {
  const ETextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.onTap,
    this.textInputType,
    this.textInputFormatter,
  });
  final bool obscureText;
  final String labelText;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatter;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      obscureText: obscureText,
      keyboardType: textInputType,
      inputFormatters: textInputFormatter,
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0.0),
        labelText: labelText,
        hintText: labelText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: const Icon(
          Icons.key,
          color: Colors.black,
          size: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
