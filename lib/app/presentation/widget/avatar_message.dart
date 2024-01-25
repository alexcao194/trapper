import 'package:flutter/material.dart';

class AvatarMessage extends StatelessWidget {
  const AvatarMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 30,
      backgroundImage: NetworkImage('https://inkythuatso.com/uploads/thumbnails/800/2022/03/anh-co-gai-cam-hoa-che-mat-1-22-15-05-30.jpg'),
    );
  }
}
