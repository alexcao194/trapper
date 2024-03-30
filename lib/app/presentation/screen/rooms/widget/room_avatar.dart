import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trapper/generated/assets.dart';

import '../../../../domain/entity/profile.dart';
import '../../../bloc/profile/profile_bloc.dart';

class RoomAvatar extends StatelessWidget {
  const RoomAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        var profile = const Profile();
        return CircleAvatar(
          maxRadius: 20,
          minRadius: 20,
          backgroundImage: (profile.photoUrl != null ? NetworkImage(profile.photoUrl!) : const AssetImage(Assets.pngDefaultAvatar)) as ImageProvider<Object>,
        );
      },
    );
  }
}
