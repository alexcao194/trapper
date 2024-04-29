import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trapper/app/presentation/screen/rooms/widget/header_message.dart';

import '../../../../generated/l10n.dart';
import '../../bloc/home/home_bloc.dart';

class SideNavigation extends StatefulWidget {
  final Function(int) onItemSelected;

  const SideNavigation({super.key, required this.onItemSelected});

  @override
  State<SideNavigation> createState() => _SideNavigationState();
}

class _SideNavigationState extends State<SideNavigation> {
  late SideMenuController _controller;

  @override
  Widget build(BuildContext context) {
    List<Icon> icons = [
      const Icon(Icons.person),
      const Icon(Icons.people),
      const Icon(Icons.connect_without_contact),
      const Icon(Icons.settings),
      const Icon(Icons.help),
    ];

    List<String> labels = [
      S.current.profile_button,
      S.current.friends_button,
      S.current.connect_button,
      S.current.settings_button,
      S.current.help_button,
    ];

    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) => previous.index != current.index,
      listener: (context, state) {
        _controller.changePage(state.index);
      },
      builder: (context, state) {
        return SideMenu(
          showToggle: true,
          title: const SizedBox(height: 8),
          footer: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    S.current.app_name,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    S.current.app_description,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          style: SideMenuStyle(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            selectedColor: Theme.of(context).colorScheme.background,
            selectedTitleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
            selectedIconColor: Theme.of(context).colorScheme.primary,
          ),
          items: List.generate(labels.length, (index) =>
              SideMenuItem(
                icon: icons[index],
                title: labels[index],
                onTap: (index, controller) {
                  widget.onItemSelected(index);
                },
              )),
          controller: _controller,
          collapseWidth: 1500,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = SideMenuController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
