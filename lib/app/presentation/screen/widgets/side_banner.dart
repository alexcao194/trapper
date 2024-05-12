import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';

class SlideBanner extends StatelessWidget {
  const SlideBanner({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 500,
                minHeight: 200,
              ),
              child: Image.asset(Assets.assetsBanner, fit: BoxFit.contain, height: size.height * 0.5)
          ),
        ),
        Text(
          S.current.app_name,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          S.current.app_description,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        )
      ],
    );
  }
}
