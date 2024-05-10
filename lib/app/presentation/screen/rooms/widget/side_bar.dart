import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/const/dimen.dart';
import '../../../../../generated/l10n.dart';
import '../../../bloc/profile/profile_bloc.dart';
import '../../../bloc/rooms/rooms_bloc.dart';
import 'header_message.dart';
import 'room_card.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  
  String _query = "";
  late SearchController _searchController;
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        return BlocBuilder<RoomsBloc, RoomsState>(
          builder: (context, roomState) {
            return Column(
              children: [
                const SizedBox(height: 8),
                if (widget.size.width > Dimen.mobileWidth) const HeaderMessage(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme
                            .of(context)
                            .colorScheme
                            .background,
                      ),
                      child: Column(children: [
                        if (widget.size.width > Dimen.mobileWidth)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                            child: SearchBar(
                              backgroundColor: MaterialStateColor.resolveWith((states) =>
                              Theme
                                  .of(context)
                                  .colorScheme
                                  .surfaceVariant),
                              onChanged: (query) {
                                _onSearch(query);
                              },
                              elevation: MaterialStateProperty.all(0),
                              controller: _searchController,
                              trailing: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.search),
                                ),
                              ],
                              hintText: S.current.search_hint,
                            ),
                          ),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              var rooms = roomState.roomsInfo.where((element) => element.profile!.name!.toLowerCase().contains(_query.toLowerCase())).toList();
                              return ListView.builder(
                                itemCount: rooms.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: MaterialButton(
                                      padding: EdgeInsets.zero,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                      onPressed: () {},
                                      child: RoomCard(
                                        userId: profileState.profile.id!,
                                        isSelecting: roomState.currentID == rooms[index].id,
                                        profile: rooms[index].profile!,
                                        lastMessage: rooms[index].lastMessage,
                                        roomID: rooms[index].id!,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _query = query;
    });
  }
}
