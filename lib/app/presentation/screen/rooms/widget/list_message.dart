import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/const/dimen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../domain/entity/message_detail.dart';
import '../../../bloc/profile/profile_bloc.dart';
import '../../../bloc/rooms/rooms_bloc.dart';
import 'image_message.dart';
import 'text_message.dart';

class ListMessage extends StatelessWidget {
  const ListMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
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
                var isSender = currentMessages![index].sender == profileState.profile.id;
                var size = MediaQuery.of(context).size;
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      if (isSender) const Spacer(),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: (size.width > Dimen.mobileWidth) ? size.width * 0.4 : size.width * 0.6,
                        ),
                        child: Builder(
                          builder: (context) {
                            switch(currentMessages![index].type) {
                              case MessageType.image:
                                return ImageMessage(
                                  src: currentMessages[index].message!,
                                );
                              case MessageType.emoji:
                                return TextMessage(
                                  isSender: isSender,
                                  message: currentMessages[index].message!,
                                );
                              default:
                                return TextMessage(
                                  isSender: isSender,
                                  message: currentMessages[index].message!,
                                );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}