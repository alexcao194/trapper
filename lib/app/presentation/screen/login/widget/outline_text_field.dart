import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';

class OutlineTextField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final String? errorText;
  final bool obscureText;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final ValueChanged<String>? onChanged;
  final Function(PointerDownEvent)? onTapOutside;

  const OutlineTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.obscureText = false,
    required this.controller,
    this.onTap,
    this.onChanged,
    this.onTapOutside,
    this.inputType,
    this.errorText,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputAction,
    this.focusNode,
  });

  @override
  State<OutlineTextField> createState() => _OutlineTextFieldState();
}

class _OutlineTextFieldState extends State<OutlineTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: widget.textInputAction,
      keyboardType: widget.inputType,
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: widget.obscureText ? obscureText : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        error: widget.errorText != null ? Text(widget.errorText!, style: TextStyle(color: Theme.of(context).colorScheme.error)) : null,
        suffix: widget.obscureText
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Text(obscureText ? S.current.show : S.current.hide, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              )
            : null,
        label: Text(widget.labelText),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.secondaryContainer, width: 2)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryContainer, width: 2)),
      ),
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onTapOutside: widget.onTapOutside,
    );
  }
}
