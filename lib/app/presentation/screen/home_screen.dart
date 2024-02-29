import 'package:flutter/material.dart';
import 'package:trapper/app/presentation/widget/avatar_message.dart';
import 'package:trapper/app/presentation/widget/header_message.dart';
import 'package:trapper/app/presentation/widget/home/connect_button.dart';
import 'package:trapper/app/presentation/widget/home/friend_button.dart';
import 'package:trapper/app/presentation/widget/home/help_button.dart';
import 'package:trapper/app/presentation/widget/home/logout_button.dart';
import 'package:trapper/app/presentation/widget/home/message_button.dart';
import 'package:trapper/app/presentation/widget/home/profile_button.dart';
import 'package:trapper/app/presentation/widget/home/setting_button.dart';
import '../../../generated/l10n.dart';
import 'package:rive/rive.dart';


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
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: SizedBox(
              width: size.width > Dimen.mobileWidth ? size.width * 0.42 : 80,
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  if (size.width > Dimen.mobileWidth) const HeaderMessage() else const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: AvatarMessage(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: 7,
                        separatorBuilder: (BuildContext context, int index) => Divider(),
                        itemBuilder: (BuildContext context, int index) {
                          switch (index) {
                            case 0:
                              return const ProfileButton();
                            case 1:
                              return const FriendsButton();
                            case 2:
                              return const MessageButton();
                            case 3:
                              return const ConnectButton();
                            case 4:
                              return const SettingButton();
                            case 5:
                              return const HelpButton();
                            case 6:
                              return const LogoutButton();
                            default:
                              return const SizedBox(); // return an empty container if the index is out of bounds
                          }
                        },
                      ),
                      ),
                    ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      //padding: const EdgeInsets.all(16),
                      child: Text(
                        S.current.app_name_annotation,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                  ]
              ),
            ),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1000,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                //color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.75),
                // child: Column(
                //   children: [
                //   SizedBox(
                //     height: 300,
                //     width: 300,
                //     child: Center(
                //       child: _artboard != null
                //           ? Rive(
                //         artboard: _artboard!,
                //         fit: BoxFit.cover,
                //       )
                //         : const SizedBox(),
                //     ),
                //   )]
                // )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
