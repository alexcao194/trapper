import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final Function(bool)? onSelected;
  final bool isSelected;

  const CustomChip({
    super.key,
    required this.label,
    this.onSelected,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (value) {
          onSelected?.call(value);
        },
      ),
    );
  }
}