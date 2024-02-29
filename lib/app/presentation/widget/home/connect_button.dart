import 'package:flutter/material.dart';

import '../../../../config/const/dimen.dart';

class ConnectButton extends StatelessWidget {
  const ConnectButton({Key? key}) : super(key: key);

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
        leading: const Icon(Icons.connect_without_contact),
        title: const Text('Connect with others'),
        onTap: () {
        },
      ) : IconButton(
        icon: const Icon(Icons.connect_without_contact),
        onPressed: () {},
      ),
    );
  }
}
