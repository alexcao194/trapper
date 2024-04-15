import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/const/dimen.dart';
import '../../../../../config/go_router/app_go_router.dart';
import '../../../../../generated/l10n.dart';
import '../../../bloc/friends/friends_bloc.dart';
import 'profile_tab.dart';

class FriendsTab extends StatefulWidget {
  const FriendsTab({super.key});

  @override
  State<FriendsTab> createState() => _FriendsTabState();
}

class _FriendsTabState extends State<FriendsTab> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FriendsBloc, FriendsState>(
      listener: (context, state) {
        if (state.showError && state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: state.friends.length,
                  itemBuilder: (context, index) {
                    final friend = state.friends[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          title: Text(friend.name!),
                          subtitle: const Text('Online'),
                          leading: CircleAvatar(
                            child: friend.photoUrl != null ? Image.network(friend.photoUrl!) : const Icon(Icons.person),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          trailing: IconButton(
                            icon: const Icon(Icons.message_outlined),
                            onPressed: () {
                              context.go(RoutePath.messages);
                            },
                          )),
                    );
                  },
                ),
              ),
            ),
            if (MediaQuery.of(context).size.width > Dimen.mobileWidth)
              state.isLoading || state.friends.isEmpty
                  ? Expanded(child: Center(child: Text(S.current.no_friends)))
                  : Expanded(
                      flex: 2,
                      child: ProfileTab(
                        profile: state.friends[_selectedIndex],
                        owner: false,
                      ),
                    ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<FriendsBloc>().add(const FriendsFetch());
  }
}
