import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../config/const/dimen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../domain/entity/message_detail.dart';
import '../../../../domain/entity/profile.dart';
import '../../../bloc/rooms/rooms_bloc.dart';
import 'room_avatar.dart';

class RoomCard extends StatelessWidget {
  final Profile profile;
  final String userId;
  final MessageDetail? lastMessage;
  final String roomID;
  final bool isSelecting;

  const RoomCard({super.key, required this.profile, this.lastMessage, required this.roomID, required this.isSelecting, required this.userId});

  @override
  Widget build(BuildContext context) {
    String time = '';
    if (lastMessage != null) {
      var dateTime = DateTime.fromMillisecondsSinceEpoch(lastMessage!.timestamp!);
      if (DateTime.now().difference(dateTime).inDays < 1) {
        time = DateFormat('HH:mm').format(dateTime);
      } else {
        time = DateFormat('dd/MM/yyyy').format(dateTime);
      }
    }

    return ListTile(
      tileColor: isSelecting ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      splashColor: Theme.of(context).colorScheme.surfaceVariant,
      leading: RoomAvatar(photoUrl: profile.photoUrl),
      trailing: Text(time, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.outline)),
      title: Text(profile.name ?? S.current.full_name_example, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
      subtitle: Text(
        (lastMessage == null) ? S.current.last_message_placeholder : _getMessage(lastMessage!, profile.id == userId),
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

  String _getMessage(MessageDetail messageDetail, bool isSender) {
    var sender = isSender ? '${S.current.you}: ' : '';
    if (messageDetail.type == MessageType.image) {
      return S.current.send_an_image(sender);
    }
    if (messageDetail.type == MessageType.emoji) {
      return S.current.send_a_emoji(sender);
    }
    return '$sender${messageDetail.message}';
  }
}
