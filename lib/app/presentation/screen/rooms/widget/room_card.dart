import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/const/dimen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../domain/entity/message_detail.dart';
import '../../../../domain/entity/profile.dart';
import '../../../bloc/rooms/rooms_bloc.dart';
import 'room_avatar.dart';

class RoomCard extends StatelessWidget {
  final Profile profile;
  final MessageDetail? lastMessage;
  final String roomID;
  final bool isSelecting;

  const RoomCard({super.key, required this.profile, this.lastMessage, required this.roomID, required this.isSelecting});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: isSelecting ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.background,
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
      onTap: () {
        _onPick(context, roomID);
      },
    );
  }

  void _onPick(BuildContext context, String id) {
    context.read<RoomsBloc>().add(RoomsPick(id: id));
    if (MediaQuery.of(context).size.width <= Dimen.mobileWidth) {
      Navigator.of(context).pop();
    }
  }
}
