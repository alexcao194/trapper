import 'package:flutter/material.dart';
import 'package:trapper/app/presentation/widget/avatar_message.dart';

class DetailHeaderMessage extends StatelessWidget {
  const DetailHeaderMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const AvatarMessage(),
      title: Text(
        "User Name",
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.more_horiz_rounded),
      ),
      onTap: () {},
    );
  }
}
