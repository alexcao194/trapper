import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/assets.dart';
import '../../../bloc/auth/auth_bloc.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
          child: Column(
                children: [
          Text("QR code", style: Theme.of(context).textTheme.titleLarge),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Image.asset(Assets.assetsQr),
            ),
          ),
          Text(
            "Clean Architecture",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Image.asset(Assets.assetsCa),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEventLogout());
            },
            child: const Text("Logout"),
          ),
                ],
              ),
        ));
  }
}
