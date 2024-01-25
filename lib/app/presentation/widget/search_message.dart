import 'package:flutter/material.dart';

class SearchMessage extends StatelessWidget {
  const SearchMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 12,
      width: MediaQuery.of(context).size.width / 7 * 2 ,
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: SearchBar(
        controller: SearchController(),
        trailing: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
        hintText: "Search...",
      ),
    );
  }

}
