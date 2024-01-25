import 'package:flutter/material.dart';

class AvatarMessage extends StatelessWidget {
  const AvatarMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('https://inkythuatso.com/uploads/thumbnails/800/2022/03/anh-co-gai-cam-hoa-che-mat-1-22-15-05-30.jpg'),
        ),
    );
  }
}
