import 'package:flutter/material.dart';

import '../../../../../../config/const/dimen.dart';

const List<String> list = <String>['Nam', 'Nữ', 'Tất cả   '];

class GenderDropdown extends StatefulWidget {
  const GenderDropdown({super.key});

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  String dropdownValue = 'Giới tính   ';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      child: DropdownButton(
        borderRadius: BorderRadius.circular(8),
        dropdownColor: Theme.of(context).colorScheme.inversePrimary,
        hint: Text(dropdownValue),
        icon: Icon(Icons.people_alt_rounded, color: Theme.of(context).colorScheme.primary),
        items: [
          for (var item in list)
            DropdownMenuItem(
              child: Row(
                children: [
                  Text(item),
                  SizedBox(width: 8),
                ],
              ),
              value: item,
            )
        ],
        onChanged: (value) {
          setState(() {
            dropdownValue = value.toString();
          });
        },
      ),
    );
  }
}


