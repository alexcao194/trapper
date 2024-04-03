import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trapper/generated/assets.dart';

class RoomAvatar extends StatelessWidget {
  final String? photoUrl;

  const RoomAvatar({super.key, required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    if (photoUrl == null) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: BoxShape.circle,
        ),
        width: 40,
        height: 40,
        child: Icon(
          Icons.person,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      );
    }

    return CircleAvatar(
      maxRadius: 20,
      minRadius: 20,
      backgroundImage: NetworkImage(photoUrl!) as ImageProvider<Object>,
    );
  }
}
