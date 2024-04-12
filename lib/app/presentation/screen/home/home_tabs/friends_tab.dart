import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/const/dimen.dart';
import '../../../../../config/go_router/app_go_router.dart';
import 'profile_tab.dart';
class FriendsTab extends StatelessWidget {
  const FriendsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Friend $index'),
                    subtitle: const Text('Online'),
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    onTap: () {

                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.message_outlined),
                      onPressed: () {
                        context.go(RoutePath.messages);
                      },
                    )
                  ),
                );
              },
            ),
          ),
        ),
        if (MediaQuery.of(context).size.width > Dimen.mobileWidth)
          const Expanded(
            flex: 2,
            child: ProfileTab(),
          ),
      ],
    );
  }
}
