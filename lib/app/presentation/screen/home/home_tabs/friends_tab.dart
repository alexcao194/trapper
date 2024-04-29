import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../config/const/dimen.dart';
import '../../../../../config/go_router/app_go_router.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/notification_tools.dart';
import '../../../../domain/entity/profile.dart';
import '../../../bloc/friends/friends_bloc.dart';
import '../../../bloc/home/home_bloc.dart';
import '../../../bloc/rooms/rooms_bloc.dart';
import 'profile_tab.dart';

class FriendsTab extends StatefulWidget {
  const FriendsTab({super.key});

  @override
  State<FriendsTab> createState() => _FriendsTabState();
}

class _FriendsTabState extends State<FriendsTab> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FriendsBloc, FriendsState>(
      listener: (context, state) {
        if (state.showError && state.error != null) {
          NotificationTools.showErrorNotification(context: context, message: state.error!);
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return LoadingAnimationWidget.fourRotatingDots(
            color: Theme.of(context).colorScheme.primary,
            size: 50,
          );
        }
        if (state.friends.isEmpty) {
          return Center(
            child: AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              title: Text(S.of(context).no_friends),
              content: Text(S.of(context).no_friend_detail),
              actions: [
                TextButton(
                  onPressed: () {
                    context.read<HomeBloc>().add(const HomeNavigate(index: 2));
                  },
                  child: Text(S.of(context).connect_button),
                ),
              ],
            ),
          );
        }
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
                          tileColor: friend.id == state.currentID ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.background,
                          title: Text(friend.name!),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.circle, color: Colors.green, size: 10),
                              const SizedBox(width: 5),
                              Text(S.current.online),
                            ],
                          ),
                          leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: friend.photoUrl != null
                                  ? Image.network(
                                      friend.photoUrl!,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(Icons.person),
                            ),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          onTap: () {
                            context.read<FriendsBloc>().add(FriendPick(friendId: friend.id!));
                            if (MediaQuery.of(context).size.width <= Dimen.mobileWidth) {
                              _showProfileDialog(state.friends[index]);
                            }
                          },
                          trailing: IconButton(
                            icon: const Icon(Icons.message_outlined),
                            onPressed: () {
                              context.read<RoomsBloc>().add(RoomPickWithUserId(userID: friend.id!));
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
                  ? const Spacer()
                  : Expanded(
                      flex: 2,
                      child: ProfileTab(
                        profile: state.friends.firstWhere((element) => element.id == state.currentID),
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

  void _showProfileDialog(Profile profile) {
    showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Scaffold(
              body: Stack(
                children: [
                  Center(
                    child: ProfileTab(
                      profile: profile,
                      owner: false,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: BackButton(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
