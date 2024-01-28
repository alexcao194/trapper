import 'package:flutter/material.dart';

class SearchMessage extends StatelessWidget {
  const SearchMessage({super.key});

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
      hintText: "Search...",
    );
  }

}