import 'package:flutter/material.dart';

import '../../../../../config/const/dimen.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap,
      required this.isActivated});

  final IconData icon;
  final String title;
  final Function() onTap;
  final bool isActivated;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isActivated
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.background,
        ),
        child: size.width > Dimen.mobileWidth
            ? ListTile(
                leading: Icon(icon,
                    color: isActivated
                        ? Theme.of(context).colorScheme.background
                        : Theme.of(context).colorScheme.onBackground),
                title: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isActivated
                      ? Theme.of(context).colorScheme.background
                      : Theme.of(context).colorScheme.onBackground,
                )),
                onTap: onTap,
              )
            : IconButton(
                icon: Icon(icon, color: isActivated
                    ? Theme.of(context).colorScheme.background
                    : Theme.of(context).colorScheme.onBackground),
                onPressed: onTap,
              ),
      ),
    );
  }
}
