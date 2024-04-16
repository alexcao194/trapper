import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/const/dimen.dart';
import '../../../domain/entity/profile.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/rooms/rooms_bloc.dart';
import 'widget/detail_header_message.dart';
import 'widget/input_message.dart';
import 'widget/side_bar.dart';
import 'widget/text_message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        return SafeArea(
          child: Scaffold(
            drawer: size.width <= Dimen.mobileWidth
                ? Drawer(
                    child: SideBar(size: size),
                  )
                : null,
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            body: Row(
              children: [
                if (size.width > Dimen.mobileWidth)
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500,
                    ),
                    child: SizedBox(
                      width: size.width * 0.42,
                      child: SideBar(size: size),
                    ),
                  ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    //color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.75),
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.onInverseSurface,
                            ),
                            child: Builder(builder: (context) {
                              return DetailHeaderMessage(
                                profile: const Profile(
                                  name: "User",
                                ),
                                onBack: () {
                                  Scaffold.of(context).openDrawer();
                                },
                              );
                            })),
                        const Expanded(
                          child: ListMessage(),
                        ),
                        const InputMessage()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<RoomsBloc>().add(RoomsFetchRoomsInfo());
  }
}

class ListMessage extends StatelessWidget {
  const ListMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: 15,
      itemBuilder: (context, index) {
        return TextMessage(
          isSender: index % 2 == 0,
        );
      },
    );
  }
}

