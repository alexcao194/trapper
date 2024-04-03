import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trapper/app/presentation/screen/rooms/widget/room_avatar.dart';
import 'package:trapper/config/go_router/app_go_router.dart';

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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            style: ListTileStyle.list,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            contentPadding: const EdgeInsets.all(4),
            leading: RoomAvatar(photoUrl: profile.photoUrl),
            title: Text(
              profile.name ?? "User",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined),
            ),
            onTap: () {
              context.go(RoutePath.home);
            },
          ),
        );
      },
    );
  }
}
