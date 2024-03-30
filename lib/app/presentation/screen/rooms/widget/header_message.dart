import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trapper/app/presentation/screen/rooms/widget/room_avatar.dart';

import '../../../../domain/entity/profile.dart';
import '../../../bloc/profile/profile_bloc.dart';

class HeaderMessage extends StatelessWidget {
  const HeaderMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        Profile profile = const Profile();
        if (state is ProfileGot) {
          profile = state.profile;
        }
        return ListTile(
          leading: const RoomAvatar(),
          title: Text(
            profile.name ?? "User",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          subtitle: Text(
            "@${profile.email ?? "username"}",
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
      },
    );
  }
}
