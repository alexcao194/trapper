import 'package:flutter/material.dart';

import '../../../config/const/dimen.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key, required this.icon, required this.title, required this.onTap});

  final Widget icon;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.background,
        ),
        child: size.width > Dimen.mobileWidth ? ListTile(
          leading: icon,
          title: Text(title),
          onTap: onTap,
        ) : IconButton(
          icon: icon,
          onPressed: onTap,
        ),
      ),
    );
  }
}
