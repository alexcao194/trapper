import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trapper/app/presentation/screen/home_tabs/connect_tab.dart';
import 'package:trapper/app/presentation/screen/home_tabs/friends_tab.dart';
import 'package:trapper/app/presentation/screen/home_tabs/help_tab.dart';
import 'package:trapper/app/presentation/screen/home_tabs/settings_tab.dart';
import 'package:trapper/app/presentation/widget/avatar_message.dart';
import 'package:trapper/app/presentation/widget/header_message.dart';
import 'package:trapper/app/presentation/widget/profile_button.dart';
import 'package:trapper/config/go_router/app_go_router.dart';
import '../../../generated/l10n.dart';


import '../../../config/const/dimen.dart';
import 'home_tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
                    child: AvatarMessage(),
                  ),
                const SizedBox(height: 8),
                ProfileButton(
                  icon: const Icon(Icons.person),
                  title: S.current.profile_button,
                  onTap: () {
                    _go(0);
                  },
                ),
                ProfileButton(
                  icon: const Icon(Icons.group),
                  title: S.current.friends_button,
                  onTap: () {
                    _go(1);
                  },
                ),
                ProfileButton(
                  icon: const Icon(Icons.message),
                  title: S.current.messages_button,
                  onTap: () {
                    context.go("/${RoutePath.messages}");
                  },
                ),
                ProfileButton(
                  icon: const Icon(Icons.connect_without_contact),
                  title: S.current.connect_button,
                  onTap: () {
                    _go(2);
                  },
                ),
                ProfileButton(
                  icon: const Icon(Icons.settings),
                  title: S.current.settings_button,
                  onTap: () {
                    _go(3);
                  },
                ),
                ProfileButton(
                  icon: const Icon(Icons.help),
                  title: S.current.help_button,
                  onTap: () {
                    _go(4);
                  },
                ),
                ProfileButton(
                  icon: const Icon(Icons.logout),
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
