import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../../../domain/entity/message_detail.dart';
import '../../../bloc/profile/profile_bloc.dart';
import '../../../bloc/rooms/rooms_bloc.dart';
import 'text_message.dart';

class ListMessage extends StatelessWidget {
  const ListMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        print('profileState: ${profileState.profile}');
        return BlocBuilder<RoomsBloc, RoomsState>(
          builder: (context, roomsState) {
            var currentMessages = roomsState.messages[roomsState.currentID];
            if (currentMessages == null || currentMessages.isEmpty) {
              currentMessages = [
                MessageDetail(
                  id: '',
                  message: S.current.last_message_placeholder,
                  sender: '',
                  timestamp: 1,
                  type: MessageType.text,
                ),
              ];
            }
            return ListView.builder(
              reverse: true,
              itemCount: currentMessages.length,
              itemBuilder: (context, index) {
                return TextMessage(
                  isSender: currentMessages![index].sender == profileState.profile.id,
                  message: currentMessages[index].message,
                );
              },
            );
          },
        );
      },
    );
  }
}