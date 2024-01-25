import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final String? errorText;
  final bool obscureText;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Function(PointerDownEvent)? onTapOutside;
  const RoundedTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
    required this.controller,
    this.onTap,
    this.onChanged,
    this.onTapOutside,
    this.errorText
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        error: errorText != null ? Text(errorText!) : null,
        label: Text(labelText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondaryContainer,
            width: 2
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: 2
          )
        ),

      ),
      onTap: onTap,
      onChanged: onChanged,
      onTapOutside: onTapOutside,
    );
  }
}