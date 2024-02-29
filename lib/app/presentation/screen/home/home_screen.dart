import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trapper/app/presentation/screen/rooms/widget/header_message.dart';
import 'package:trapper/app/presentation/screen/home/widget/profile_button.dart';
import 'package:trapper/app/presentation/screen/rooms/widget/room_avatar.dart';
import 'package:trapper/config/go_router/app_go_router.dart';
import '../../../../generated/l10n.dart';


import '../../../../config/const/dimen.dart';
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

class _HomeScreenState extends State<HomeScreen>{
  PageController? _pageController;
  int index = 0;

  @override
  void initState() {
    super.initState();
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
    _pageController?.animateToPage(
        index,
        duration: const Duration(milliseconds: 800),
        curve: Curves.fastOutSlowIn
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go("/${RoutePath.messages}");
        },
        child: const Icon(Icons.message),
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: Row(
        children: [
          SizedBox(
            width: size.width > Dimen.mobileWidth ? 400 : 80,
            child: Column(
              children: [
                if (size.width > Dimen.mobileWidth)
                  const HeaderMessage()
                else
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: RoomAvatar(),
                  ),
                const SizedBox(height: 8),
                ProfileButton(
                  isActivated: index == 0,
                  icon: Icons.person,
                  title: S.current.profile_button,
                  onTap: () {
                    _go(0);
                  },
                ),
                ProfileButton(
                  isActivated: index == 1,
                  icon: Icons.group,
                  title: S.current.friends_button,
                  onTap: () {
                    _go(1);
                  },
                ),
                ProfileButton(
                  isActivated: index == 2,
                  icon: Icons.connect_without_contact,
                  title: S.current.connect_button,
                  onTap: () {
                    _go(2);
                  },
                ),
                ProfileButton(
                  isActivated: index == 3,
                  icon: Icons.settings,
                  title: S.current.settings_button,
                  onTap: () {
                    _go(3);
                  },
                ),
                ProfileButton(
                  isActivated: index == 4,
                  icon: Icons.help,
                  title: S.current.help_button,
                  onTap: () {
                    _go(4);
                  },
                ),
                ProfileButton(
                  isActivated: false,
                  icon: Icons.logout,
                  title: S.current.logout_button,
                  onTap: () {

                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: PageView(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    children: const [
                      Center(child: ProfileTab()),
                      Center(child: FriendsTab()),
                      Center(child: ConnectTab()),
                      Center(child: SettingsTab()),
                      Center(child: HelpTab()),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
