import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String? errorText;
  final bool obscureText;
  final bool enabled;
  final VoidCallback? onTap;

  const FormTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.errorText,
    this.obscureText = false,
    this.enabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        enabled: enabled,
        onTap: onTap,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          label: Text(labelText),
          error: errorText != null ? Text(errorText!, style: TextStyle(color: Theme.of(context).colorScheme.error)) : null,
        ),
      ),
    );
  }
}
