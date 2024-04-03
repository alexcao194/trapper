import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trapper/app/presentation/screen/rooms/widget/detail_header_message.dart';
import 'package:trapper/app/presentation/screen/rooms/widget/header_message.dart';
import 'package:trapper/app/presentation/screen/rooms/widget/input_message.dart';
import 'package:trapper/app/presentation/screen/rooms/widget/room_card.dart';
import 'package:trapper/app/presentation/screen/rooms/widget/room_search_bar.dart';
import 'package:trapper/app/presentation/screen/rooms/widget/text_message.dart';

import '../../../../config/const/dimen.dart';
import '../../../domain/entity/profile.dart';
import '../../bloc/profile/profile_bloc.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            drawer: size.width <= Dimen.mobileWidth ? Drawer(
              child: SideBar(size: size),
            ) : null,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.person_add),
              ),
            ),
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
                            child: Builder(
                              builder: (context) {
                                return DetailHeaderMessage(
                                  profile: const Profile(
                                    name: "User",
                                  ),
                                  onBack: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                );
                              }
                            )),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return TextMessage(
                                isSender: index % 3 == 0,
                              );
                            },
                          ),
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

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        if (size.width > Dimen.mobileWidth) const HeaderMessage(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.background,
              ),
              child: Column(children: [
                if (size.width > Dimen.mobileWidth)
                  const Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: RoomSearchBar(),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                          ),
                          onPressed: () {},
                          child: const RoomCard(
                            profile: Profile(
                              name: "User",
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
