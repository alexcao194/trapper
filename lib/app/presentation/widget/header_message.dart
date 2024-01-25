import 'package:flutter/material.dart';
import 'package:trapper/app/presentation/widget/avatar_message.dart';

class HeaderMessage extends StatelessWidget {
  const HeaderMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const AvatarMessage(),
      title: Text(
        "Annona",
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "@lna17",
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontStyle: FontStyle.italic,
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_none_outlined),
      ),
      onTap: () {},
    );
  }
}
