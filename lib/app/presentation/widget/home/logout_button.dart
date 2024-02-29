import 'package:flutter/material.dart';

import '../../../../config/const/dimen.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.background
      ),
      child: size.width > Dimen.mobileWidth ? ListTile(
        leading: const Icon(Icons.logout),
        title: const Text('Logout'),
        onTap: () {
        },
      ) : IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () {},
      ),
    );
  }
}