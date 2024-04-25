import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trapper/app/presentation/bloc/home/home_bloc.dart';

import '../../../../../config/go_router/app_go_router.dart';
import '../../../../../generated/l10n.dart';
import '../../../bloc/profile/profile_bloc.dart';
import 'room_avatar.dart';

class HeaderMessage extends StatelessWidget {
  const HeaderMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        var profile = state.profile;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                style: ListTileStyle.list,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                contentPadding: const EdgeInsets.all(4),
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: RoomAvatar(
                    photoUrl: profile.photoUrl,
                  ),
                ),
                title: Text(
                  profile.name ?? S.current.full_name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                onTap: () {
                  context.read<HomeBloc>().add(const HomeNavigate(index: 0));
                  context.go(RoutePath.home);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
