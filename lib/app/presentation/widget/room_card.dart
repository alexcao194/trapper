import 'package:flutter/material.dart';
import 'package:trapper/app/presentation/widget/room_avatar.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const RoomAvatar(),
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
