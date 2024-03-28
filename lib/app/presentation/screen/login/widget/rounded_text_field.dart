import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final String? errorText;
  final bool obscureText;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final Function(PointerDownEvent)? onTapOutside;
  const RoundedTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.obscureText = false,
    required this.controller,
    this.onTap,
    this.onChanged,
    this.onTapOutside,
    this.errorText,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        error: errorText != null ? Text(errorText!, style: TextStyle(color: Theme.of(context).colorScheme.error)) : null,
        label: Text(labelText),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondaryContainer,
            width: 2
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
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