import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';

class RoomSearchBar extends StatelessWidget {
  const RoomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      backgroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).colorScheme.surfaceVariant),
      elevation: MaterialStateProperty.all(0),
      controller: SearchController(),
      trailing: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
      ],
      hintText: S.current.search_hint,
    );
  }

}
