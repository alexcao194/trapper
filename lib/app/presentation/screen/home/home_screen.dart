import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:trapper/app/presentation/bloc/profile/profile_bloc.dart';
import 'package:trapper/app/presentation/screen/home/home_tabs/widget/keep_alive_page.dart';
import 'package:trapper/app/presentation/screen/rooms/widget/header_message.dart';
import 'package:trapper/app/presentation/screen/rooms/widget/room_avatar.dart';
import 'package:trapper/config/go_router/app_go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';

import '../../../../config/const/dimen.dart';
import '../../../domain/entity/profile.dart';
import 'home_tabs/connect_tab.dart';
import 'home_tabs/friends_tab.dart';
import 'home_tabs/help_tab.dart';
import 'home_tabs/profile_tab.dart';
import 'home_tabs/settings_tab.dart';
import 'home_tabs/widget/profile_button.dart';

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
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          var profile = const Profile();
          if (state is ProfileGot) {
            profile = state.profile;
          }
          return Scaffold(
            bottomNavigationBar: MoltenBottomNavigationBar(
              selectedIndex: index,
              onTabChange: _go,
              margin: const EdgeInsets.only(bottom: 12, top: 4),
              tabs: [
                MoltenTab(
                  icon: const Icon(Icons.person),
                  selectedColor: Theme.of(context).colorScheme.primary,
                  unselectedColor: Theme.of(context).colorScheme.onSurface,
                  title: Text(S.current.profile_button),
                ),
                MoltenTab(
                  icon: const Icon(Icons.people),
                  selectedColor: Theme.of(context).colorScheme.primary,
                  unselectedColor: Theme.of(context).colorScheme.onSurface,
                  title: Text(S.current.friends_button),
                ),
                MoltenTab(
                  icon: const Icon(Icons.connect_without_contact),
                  selectedColor: Theme.of(context).colorScheme.primary,
                  unselectedColor: Theme.of(context).colorScheme.onSurface,
                  title: Text(S.current.connect_button),
                ),
                MoltenTab(
                  icon: const Icon(Icons.settings),
                  selectedColor: Theme.of(context).colorScheme.primary,
                  unselectedColor: Theme.of(context).colorScheme.onSurface,
                  title: Text(S.current.settings_button),
                ),
                MoltenTab(
                  icon: const Icon(Icons.help),
                  selectedColor: Theme.of(context).colorScheme.primary,
                  unselectedColor: Theme.of(context).colorScheme.onSurface,
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
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
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
                  )),
            )
          );
        },
      ),
    );
  }
}
