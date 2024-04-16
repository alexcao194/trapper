import 'package:flutter/material.dart';
import 'package:trapper/app/domain/entity/message_detail.dart';

import '../../../../../generated/l10n.dart';
import '../../../../domain/entity/profile.dart';
import 'room_avatar.dart';

class RoomCard extends StatelessWidget {
  final Profile profile;
  final MessageDetail? lastMessage;

  const RoomCard({super.key, required this.profile, this.lastMessage});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      splashColor: Theme.of(context).colorScheme.surfaceVariant,
      leading: RoomAvatar(photoUrl: profile.photoUrl),
      trailing: Text("Date", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.outline)),
      title: Text(profile.name ?? S.current.full_name_example, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
      subtitle: Text(
        (lastMessage == null) ? S.current.last_message_placeholder : lastMessage!.message,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.outline),
      ),
      onTap: () {},
    );
  }
}
