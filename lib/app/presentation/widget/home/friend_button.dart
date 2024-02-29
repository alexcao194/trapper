import 'package:flutter/material.dart';

import '../../../../config/const/dimen.dart';

class FriendsButton extends StatelessWidget {
  const FriendsButton({Key? key}) : super(key: key);

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
        leading: const Icon(Icons.people),
        title: const Text('Friends'),
        onTap: () {
        },
      ) : IconButton(
        icon: const Icon(Icons.people),
        onPressed: () {},
      ),
    );
  }
}