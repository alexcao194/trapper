import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';

class RoundedTextField extends StatefulWidget {
  final BorderRadius? borderRadius;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool obscureText;
  final String? errorText;
  final Widget? prefixIcon;
  final bool enabled;
  final String label;

  const RoundedTextField({
    super.key,
    this.borderRadius,
    required this.hintText,
    this.controller,
    this.inputType,
    this.enabled = true,
    this.obscureText = false,
    this.errorText,
    this.prefixIcon,
    required this.label,
  });

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(widget.label, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
            ),
            child: Center(
              child: TextField(
                obscureText: widget.obscureText ? _obscureText : false,
                controller: widget.controller,
                enabled: widget.enabled,
                keyboardType: widget.inputType,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  prefixIcon: widget.prefixIcon,
                  border: InputBorder.none,
                  suffix: widget.obscureText
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Text(_obscureText ? S.current.show : S.current.hide, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                        )
                      : null,
                ),
              ),
            ),
          ),
          if (widget.errorText != null)
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 4),
              child: Text(widget.errorText!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ),
        ],
      ),
    );
  }
}
