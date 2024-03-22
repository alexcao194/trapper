import 'package:flutter/material.dart';

class AddHobbies extends StatefulWidget {
  const AddHobbies({super.key});

  @override
  State<AddHobbies> createState() => _AddHobbiesState();
}

class _AddHobbiesState extends State<AddHobbies> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        child: Row(
          children: [
            const Icon(Icons.add),
            const Text('Add hobbies'),
          ],
        ),
        onPressed: ()=>Dialog(
          child: Column(
            children: [
              const Text('Add hobbies'),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Hobbies',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              ),
            ],
          ),
        )
    );
  }
}
