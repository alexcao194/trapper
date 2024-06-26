import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/const/dimen.dart';
import '../../bloc/profile/profile_bloc.dart';
import 'widget/detail_header_message.dart';
import 'widget/input_message.dart';
import 'widget/list_message.dart';
import 'widget/side_bar.dart';

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
}

