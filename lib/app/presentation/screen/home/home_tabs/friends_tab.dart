import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/go_router/app_go_router.dart';
class FriendsTab extends StatelessWidget {
  const FriendsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              onTap: () {

              },
              trailing: IconButton(
                icon: const Icon(Icons.message_outlined),
                onPressed: () {
                  context.go('/${RoutePath.messages}');
                },
              )
            ),
          );
        },
      ),
    );
  }
}
