import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/go_router/app_go_router.dart';
import '../../../../generated/l10n.dart';

import '../../bloc/connect/connect_bloc.dart';
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
  int index = 0;
  bool _showName = true;

  @override
  void initState() {
    super.initState();
    context.read<RoomsBloc>().add(const RoomsFetchRoomsInfo());
    context.read<ProfileBloc>().add(const ProfileEventGet());
    context.read<ConnectBloc>().add(const ConnectFetchHobbies());
    _pageController = PageController(
      initialPage: index,
    );
    _pageController?.addListener(() {
      setState(() {
        if (_pageController?.page?.round() != index && mounted) {
          index = _pageController!.page!.round();
        }
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        if (mounted) {
          _showName = false;
        }
      });
    });
  }

  _go(int index) {
    _pageController?.animateToPage(index, duration: const Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<RoomsBloc, RoomsState>(
        builder: (context, roomsState) {
          return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, profileState) {
              return Scaffold(
                  bottomNavigationBar: FlashyTabBar(
                    selectedIndex: index,
                    onItemSelected: _go,
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
                        KeepAlivePage(child: Center(child: ProfileTab(profile: profileState.profile))),
                        const KeepAlivePage(child: Center(child: FriendsTab())),
                        const KeepAlivePage(child: Center(child: ConnectTab())),
                        const KeepAlivePage(child: Center(child: SettingsTab())),
                        const KeepAlivePage(child: Center(child: HelpTab())),
                      ],
                    ),
                  ));
            },
          );
        },
      ),
    );
  }

  void _openMessages(BuildContext context) {
    context.push(RoutePath.messages);
  }
}
