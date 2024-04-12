import 'package:flutter/material.dart';

import '../../../../domain/entity/profile.dart';
import 'room_avatar.dart';

class RoomCard extends StatelessWidget {
  final Profile profile;

  const RoomCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      splashColor: Theme.of(context).colorScheme.surfaceVariant,
      leading: RoomAvatar(photoUrl: profile.photoUrl),
      trailing: Text("Date", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.outline)),
      title: Text("User Name", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
      subtitle: Text("Latest Message", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.outline)),
      onTap: () {},
    );
  }
}
