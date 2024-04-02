import 'package:flutter/material.dart';
import 'package:trapper/app/domain/entity/profile.dart';
import 'package:trapper/app/presentation/screen/rooms/widget/room_avatar.dart';

class DetailHeaderMessage extends StatelessWidget {
  final Profile profile;
  const DetailHeaderMessage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: RoomAvatar(
        photoUrl: profile.photoUrl,
      ),
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
