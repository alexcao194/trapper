import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trapper/app/presentation/bloc/auth/auth_bloc.dart';

import '../../../../config/go_router/app_go_router.dart';
import '../../../../generated/l10n.dart';

import '../../bloc/connect/connect_bloc.dart';
import '../../bloc/friends/friends_bloc.dart';
import '../../bloc/home/home_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/rooms/rooms_bloc.dart';
import 'home_tabs/connect_tab.dart';
import 'home_tabs/friends_tab.dart';
import 'home_tabs/help_tab.dart';
import 'home_tabs/profile_tab.dart';
import 'home_tabs/settings_tab.dart';
import 'home_tabs/widget/keep_alive_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController? _pageController;
  bool _showName = true;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthEventValidateToken());
    context.read<ProfileBloc>().add(const ProfileEventGet());
    context.read<ConnectBloc>().add(const ConnectFetchHobbies());
    context.read<FriendsBloc>().add(const FriendsFetch());
    _pageController = PageController();
    context.read<HomeBloc>().add(HomeInitial(pageController: _pageController!));

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showName = false;
        });
      }
    });

    context.read<AuthBloc>().stream.listen((state) {
      if (mounted) {
        if (state is AuthStateUnauthenticated || state is AuthStateFailure) {
          context.pushReplacement(RoutePath.login);
        }
      }
    });
  }

  _go(int index) {
    _pageController?.animateToPage(index, duration: const Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, homeState) {
          return BlocListener<FriendsBloc, FriendsState>(
            listenWhen: (previous, current) => current.showMessages == true && current.message != previous.message,
            listener: (context, state) {
              if (state.showMessages) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message!),
                ));
              }
            },
            child: BlocBuilder<RoomsBloc, RoomsState>(
              builder: (context, roomsState) {
                return BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, profileState) {
                    return Scaffold(
                        bottomNavigationBar: FlashyTabBar(
                          selectedIndex: homeState.index,
                          onItemSelected: (index) {
                            if (profileState.profile.name == null) {
                              return;
                            }
                            _go(index);
                          },
                          items: [
                            FlashyTabBarItem(
                              icon: const Icon(Icons.person),
                              title: Text(S.current.profile_button),
                            ),
                            FlashyTabBarItem(
                              icon: const Icon(Icons.people),
                              title: Text(S.current.friends_button),
                            ),
                            FlashyTabBarItem(
                              icon: const Icon(Icons.connect_without_contact),
                              title: Text(S.current.connect_button),
                            ),
                            FlashyTabBarItem(
                              icon: const Icon(Icons.settings),
                              title: Text(S.current.settings_button),
                            ),
                            FlashyTabBarItem(
                              icon: const Icon(Icons.help),
                              title: Text(S.current.help_button),
                            ),
                          ],
                        ),
                        floatingActionButton: roomsState.roomsInfo.isNotEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (_showName)
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                      child: Text(
                                        roomsState.roomsInfo.first.profile!.name ?? S.current.full_name,
                                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                              color: Theme.of(context).colorScheme.onPrimary,
                                            ),
                                      ),
                                    ),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Theme.of(context).colorScheme.primary,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          _openMessages(context);
                                        },
                                        child: (roomsState.roomsInfo.first.profile!.photoUrl == null)
                                            ? const Icon(Icons.person)
                                            : Image.network(
                                                roomsState.roomsInfo.first.profile!.photoUrl!,
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : null,
                        body: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PageView(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              KeepAlivePage(child: ProfileTab(profile: profileState.profile)),
                              const KeepAlivePage(child: FriendsTab()),
                              const KeepAlivePage(child: ConnectTab()),
                              const KeepAlivePage(child: SettingsTab()),
                              const KeepAlivePage(child: HelpTab()),
                            ],
                          ),
                        ));
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _openMessages(BuildContext context) {
    context.push(RoutePath.messages);
  }
}
