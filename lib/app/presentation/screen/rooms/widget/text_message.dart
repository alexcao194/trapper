import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({super.key, required this.isSender});

  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          if (isSender) Expanded(child: Container()),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: isSender
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text("Hello,aaaa aaa how are you?",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: isSender
                          ? Theme.of(context).colorScheme.background
                          : Theme.of(context).colorScheme.onBackground,
                    )),
          ),
        ],
      ),
    );
  }
}
