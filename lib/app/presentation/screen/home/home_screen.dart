import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:trapper/app/presentation/bloc/connect/connect_bloc.dart';
import 'package:trapper/app/presentation/bloc/profile/profile_bloc.dart';
import 'package:trapper/app/presentation/screen/home/home_tabs/widget/keep_alive_page.dart';
import 'package:trapper/config/go_router/app_go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';

import 'home_tabs/connect_tab.dart';
import 'home_tabs/friends_tab.dart';
import 'home_tabs/help_tab.dart';
import 'home_tabs/profile_tab.dart';
import 'home_tabs/settings_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController? _pageController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileEventGet());
    context.read<ConnectBloc>().add(const ConnectFetchHobbies());
    _pageController = PageController(
      initialPage: index,
    );
    _pageController?.addListener(() {
      setState(() {
        index = _pageController!.page!.round();
      });
    });
  }

  _go(int index) {
    _pageController?.animateToPage(index, duration: const Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.go(RoutePath.messages);
            },
            child: const Icon(Icons.message),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                KeepAlivePage(child: Center(child: ProfileTab())),
                KeepAlivePage(child: Center(child: FriendsTab())),
                KeepAlivePage(child: Center(child: ConnectTab())),
                KeepAlivePage(child: Center(child: SettingsTab())),
                KeepAlivePage(child: Center(child: HelpTab())),
              ],
            ),
          )),
    );
  }
}
