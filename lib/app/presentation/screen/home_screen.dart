import 'package:flutter/material.dart';
import 'package:trapper/app/presentation/widget/avatar_message.dart';
import 'package:trapper/app/presentation/widget/header_message.dart';
import 'package:trapper/app/presentation/widget/profile_button.dart';
import '../../../generated/l10n.dart';


import '../../../config/const/dimen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                if (size.width > Dimen.mobileWidth) const HeaderMessage() else const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: AvatarMessage(),
                ),
                const SizedBox(height: 8),
                ProfileButton(
                  icon: const Icon(Icons.person),
                  title: S.current.profile_button,
                  onTap: () {},
                ),
                ProfileButton(
                  icon: const Icon(Icons.group),
                  title: S.current.friends_button,
                  onTap: () {},
                ),
                ProfileButton(
                  icon: const Icon(Icons.message),
                  title: S.current.messages_button,
                  onTap: () {},
                ),
                ProfileButton(
                  icon: const Icon(Icons.connect_without_contact),
                  title: S.current.connect_button,
                  onTap: () {},
                ),
                ProfileButton(
                  icon: const Icon(Icons.settings),
                  title: S.current.settings_button,
                  onTap: () {},
                ),
                ProfileButton(
                  icon: const Icon(Icons.help),
                  title: S.current.help_button,
                  onTap: () {},
                ),
                ProfileButton(
                  icon: const Icon(Icons.logout),
                  title: S.current.logout_button,
                  onTap: () {},
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
