import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/const/dimen.dart';
import '../../../../../config/go_router/app_go_router.dart';
import '../../../../../generated/l10n.dart';
import '../../../bloc/friends/friends_bloc.dart';
import '../../../bloc/home/home_bloc.dart';
import '../../../bloc/rooms/rooms_bloc.dart';

class DetailHeaderMessage extends StatefulWidget {
  final VoidCallback onBack;

  const DetailHeaderMessage({super.key, required this.onBack});

  @override
  State<DetailHeaderMessage> createState() => _DetailHeaderMessageState();
}

class _DetailHeaderMessageState extends State<DetailHeaderMessage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<FriendsBloc, FriendsState>(
      builder: (context, friendsState) {
        return BlocBuilder<RoomsBloc, RoomsState>(
          builder: (context, roomState) {
            if (roomState.roomsInfo.isEmpty) {
              return Center(
                child: Text(S.current.loading),
              );
            }
            final room = roomState.roomsInfo.firstWhere((element) => element.id == roomState.currentID);
            final profile = room.profile;
            final isFriend = room.isFriend || friendsState.friends.any((element) => element.id == profile!.id);
            return ListTile(
              leading: size.width <= Dimen.mobileWidth
                  ? IconButton(
                      onPressed: widget.onBack,
                      icon: const Icon(Icons.arrow_back),
                    )
                  : null,
              title: Text(
                profile!.name ?? S.current.full_name_example,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              trailing: Wrap(
                children: [
                  if (size.width <= Dimen.mobileWidth)
                    IconButton(
                      onPressed: () {
                        context.go(RoutePath.home);
                        context.read<HomeBloc>().add(const HomeNavigate(index: 0));
                      },
                      icon: const Icon(Icons.home),
                    ),
                  if (!isFriend)
                    IconButton(
                      onPressed: () {
                        _onAddFriend(profile.id!);
                      },
                      icon: const Icon(Icons.person_add),
                    )
                ],
              ),
              onTap: () {
                if (!isFriend) {
                  return;
                }
                context.read<FriendsBloc>().add(FriendPick(friendId: profile.id!));
                context.read<HomeBloc>().add(const HomeNavigate(index: 1));
                context.go(RoutePath.home);
              },
            );
          },
        );
      },
    );
  }

  void _onAddFriend(String id) {
    context.read<FriendsBloc>().add(FriendsAdd(friendId: id));
  }
}
