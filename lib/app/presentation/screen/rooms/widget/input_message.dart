import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';

class InputMessage extends StatelessWidget {
  const InputMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: S.current.text_message_hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        fillColor: Theme.of(context).colorScheme.background,
        filled: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.image_outlined),
          ),
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.emoji_emotions_outlined),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                },
                icon: const Icon(Icons.send_sharp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
