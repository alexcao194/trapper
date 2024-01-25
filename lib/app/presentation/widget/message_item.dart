import 'package:flutter/material.dart';
import 'package:trapper/app/presentation/widget/avatar_message.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const AvatarMessage(),
      trailing: Text("Date",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.outline,
              )),
      title: Text("User Name",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              )),
      subtitle: Text("Latest Message", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.outline,
      )),
      onTap: () {},
    );
  }
}
