import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trapper/config/go_router/app_go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(RoutePath.messages);
        },
        child: const Icon(Icons.arrow_forward),
      ),
      body: const Center(
        child: Text('Login Screen'),
      )
    );
  }
}
