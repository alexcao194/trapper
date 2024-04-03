import 'package:flutter/material.dart';
import 'package:trapper/app/domain/entity/profile.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/const/dimen.dart';
import '../../../../../config/go_router/app_go_router.dart';

class DetailHeaderMessage extends StatelessWidget {
  final Profile profile;
  final VoidCallback onBack;

  const DetailHeaderMessage({super.key, required this.profile, required this.onBack});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListTile(
      leading: size.width <= Dimen.mobileWidth
          ? IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back),
            )
          : null,
      title: Text(
        profile.name ?? "User",
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.more_horiz_rounded),
      ),
      onTap: () {
        context.go(RoutePath.home);
      },
    );
  }
}
