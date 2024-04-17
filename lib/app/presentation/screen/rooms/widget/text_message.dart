import 'package:flutter/material.dart';

import '../../../../../config/const/dimen.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({super.key, required this.isSender, required this.message});

  final bool isSender;
  final String message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          if (isSender) Expanded(child: Container()),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: (size.width > Dimen.mobileWidth) ? size.width * 0.4 : size.width * 0.6,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isSender ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: isSender ? Theme.of(context).colorScheme.background : Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
