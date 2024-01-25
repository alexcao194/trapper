import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.arrow_forward),
      ),
      body: Center(
        child: Text('Login Screen'),
      )
    );
  }
}
