import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/const/dimen.dart';
import '../../../../../config/go_router/app_go_router.dart';
import '../../../../../generated/l10n.dart';
import '../../../../domain/entity/profile.dart';
import '../../../bloc/friends/friends_bloc.dart';
import '../../../bloc/rooms/rooms_bloc.dart';

class DetailHeaderMessage extends StatefulWidget {
  final VoidCallback onBack;

  const DetailHeaderMessage({super.key, required this.onBack});

  @override
  State<DetailHeaderMessage> createState() => _DetailHeaderMessageState();
}

class _DetailHeaderMessageState extends State<DetailHeaderMessage> {

  String friendState = 'none';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<RoomsBloc, RoomsState>(
      builder: (context, state) {
        if (state.roomsInfo.isEmpty) {
          return Center(
            child: Text(S.current.loading),
          );
        }
        final profile = state.roomsInfo.firstWhere((element) => element.id == state.currentID).profile;
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
          trailing: (friendState != "friend") ? IconButton(
            onPressed: () {
              _onAddFriend(profile.id!);
            },
            icon: Icon(friendState == "none" ? Icons.person_add : Icons.check),
          ) : null,
          onTap: () {
            context.go(RoutePath.home);
          },
        );
      },
    );
  }

  void _onAddFriend(String id) {
    context.read<FriendsBloc>().add(FriendsAdd(friendId: id));
    setState(() {
      friendState = "requested";
    });
  }
}
