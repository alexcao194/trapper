import 'dart:html';

import 'package:flutter/material.dart';
import 'package:trapper/app/presentation/screen/home/home_tabs/widget/add_hobbies.dart';
import 'package:trapper/app/presentation/screen/home/home_tabs/widget/age_dropdown.dart';
import 'package:trapper/app/presentation/screen/home/home_tabs/widget/gender_dropdown.dart';
import 'package:trapper/app/presentation/screen/home/home_tabs/widget/location_dropdown.dart';

class ConnectTab extends StatelessWidget {
  const ConnectTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Bạn muốn tìm người như thế nào?',
                style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: SearchBar(
                        hintText: 'Tìm kiếm',
                        leading: Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  ActionChip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                      label: Icon(Icons.arrow_forward, color: Theme.of(context).colorScheme.onPrimary),
                      onPressed: (){}
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt)),
                      Text("Lọc", style: TextStyle(fontSize: 15)),
                      SizedBox(width: 10.0),
                      GenderDropdown(),
                      SizedBox(width: 10.0),
                      AgeDropDown(),
                      SizedBox(width: 10.0),
                      LocationDropDown(),
                      SizedBox(width: 10.0),
                      AddHobbies(),
                    ]
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
