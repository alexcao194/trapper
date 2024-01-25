import 'package:flutter/material.dart';

class AvatarMessage extends StatelessWidget {
  const AvatarMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      maxRadius: 20,
      minRadius: 20,
      backgroundImage: NetworkImage('https://picsum.photos/200', scale: 0.5),
    );
  }
}
