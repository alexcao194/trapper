import 'package:flutter/material.dart';

const List<String> list = <String>['Dưới 10 tuổi', 'Từ 11 - 15 tuổi ', 'Từ 16-20 tuổi',
  'Từ 21-25 tuổi ', "Từ 26-30 tuổi", 'Từ 31-35 tuổi', 'Từ 36-40 tuổi', 'Từ 40-45 tuổi',
  'Từ 45-50 tuổi', 'Trên 50 tuổi',  'Mọi độ tuổi '];

class AgeDropDown extends StatefulWidget {
  const AgeDropDown({super.key});
  @override
  State<AgeDropDown> createState() => _AgeDropDownState();
}

class _AgeDropDownState extends State<AgeDropDown> {
  String dropdownValue = 'Độ tuổi';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      child: DropdownButton(
        menuMaxHeight: 300,
        dropdownColor: Theme.of(context).colorScheme.inversePrimary,
        hint : Text(dropdownValue),
        icon: Icon(Icons.stacked_bar_chart, color: Theme.of(context).colorScheme.primary),
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
