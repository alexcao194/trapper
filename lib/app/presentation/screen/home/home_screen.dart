import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


import '../../../../config/const/dimen.dart';
import '../../../../config/go_router/app_go_router.dart';
import '../../../../generated/l10n.dart';

import '../../../../utils/notification_tools.dart';
import '../../../domain/entity/message_detail.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/connect/connect_bloc.dart';
import '../../bloc/friends/friends_bloc.dart';
import '../../bloc/home/home_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/rooms/rooms_bloc.dart';
import '../widgets/side_navigation.dart';
import 'home_tabs/connect_tab.dart';
import 'home_tabs/friends_tab.dart';
import 'home_tabs/about_tab.dart';
import 'home_tabs/profile_tab.dart';
import 'home_tabs/settings_tab.dart';
import 'home_tabs/widget/keep_alive_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController? _pageController;
  bool _showLastMessage = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<AuthBloc>().add(const AuthEventValidateToken());
    context.read<ProfileBloc>().add(const ProfileEventGet());
    context.read<ConnectBloc>().add(const ConnectFetchHobbies());
    context.read<FriendsBloc>().add(const FriendsFetch());
    context.read<HomeBloc>().add(HomeInitial(pageController: _pageController!));
  }

  _go(int index) {
    _pageController?.animateToPage(index, duration: const Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateUnauthenticated) {
            _logout();
          }
        },
        builder: (context, authState) {
          return BlocBuilder<HomeBloc, HomeState>(
            builder: (context, homeState) {
              return BlocListener<FriendsBloc, FriendsState>(
                listener: (context, state) {
                  if (state.showMessages) {
                    NotificationTools.showNotification(context: context, message: state.message!);
                  }
                },
                child: BlocConsumer<RoomsBloc, RoomsState>(
                  listenWhen: (previous, roomsState) => previous.roomsInfo.isEmpty || roomsState.roomsInfo.first.lastMessage != previous.roomsInfo.first.lastMessage,
                  listener: (context, roomsState) {
                    if (roomsState.roomsInfo.isNotEmpty) {
                      setState(() {
                        _showLastMessage = true;
                        _waitHideLastMessage();
                      });
                    }
                  },
                  builder: (context, roomsState) {
                    return BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, profileState) {
                        var size = MediaQuery.of(context).size;
                        return Stack(
                          children: [
                            Scaffold(
                              backgroundColor: Theme.of(context).colorScheme.background,
                              bottomNavigationBar: (size.width <= Dimen.mobileWidth) ? FlashyTabBar(
                                selectedIndex: homeState.index,
                                onItemSelected: (index) {
                                  if (profileState.profile.name == null) {
                                    return;
                                  }
                                  _go(index);
                                },
                                items: [
                                  FlashyTabBarItem(
                                    icon: const Icon(Icons.person),
                                    title: Text(S.current.profile_button),
                                  ),
                                  FlashyTabBarItem(
                                    icon: const Icon(Icons.people),
                                    title: Text(S.current.friends_button),
                                  ),
                                  FlashyTabBarItem(
                                    icon: const Icon(Icons.connect_without_contact),
                                    title: Text(S.current.connect_button),
                                  ),
                                  FlashyTabBarItem(
                                    icon: const Icon(Icons.settings),
                                    title: Text(S.current.settings_button),
                                  ),
                                  // FlashyTabBarItem(
                                  //   icon: const Icon(Icons.info),
                                  //   title: Text(S.current.about_button),
                                  // ),
                                ],
                              ) : null,
                              floatingActionButton: roomsState.roomsInfo.isNotEmpty
                                  ? Builder(
                                  builder: (context) {
                                    var lastMessage = roomsState.roomsInfo.first.lastMessage ?? MessageDetail(
                                      type: MessageType.text,
                                      message: S.current.last_message_placeholder,
                                    );
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (_showLastMessage)
                                          Container(
                                            margin: const EdgeInsets.only(right: 10),
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                            child: Text(
                                              getMessage(lastMessage, lastMessage.sender == profileState.profile.id),
                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                color: Theme.of(context).colorScheme.onPrimary,
                                              ),
                                            ),
                                          ),
                                        MaterialButton(
                                          shape: const CircleBorder(),
                                          onPressed: () {
                                            if (_showLastMessage) {
                                              _openMessages(context);
                                            } else {
                                              setState(() {
                                                _showLastMessage = true;
                                              });
                                              _waitHideLastMessage();
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Theme.of(context).colorScheme.primary,
                                                width: 2,
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: (roomsState.roomsInfo.first.profile!.photoUrl == null)
                                                  ? const Icon(Icons.person)
                                                  : Image.network(
                                                roomsState.roomsInfo.first.profile!.photoUrl!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                              )
                                  : null,
                              body: Row(
                                children: [
                                  if (size.width > Dimen.mobileWidth) SideNavigation(
                                    onItemSelected: _go,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: PageView(
                                        scrollDirection: size.width > Dimen.mobileWidth ? Axis.vertical : Axis.horizontal,
                                        controller: _pageController,
                                        physics: const NeverScrollableScrollPhysics(),
                                        children: [
                                          KeepAlivePage(child: ProfileTab(profile: profileState.profile)),
                                          const KeepAlivePage(child: FriendsTab()),
                                          const KeepAlivePage(child: ConnectTab()),
                                          const KeepAlivePage(child: SettingsTab()),
                                          // const KeepAlivePage(child: AboutTab()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (profileState.profile.name == null || authState is AuthStateLoading)
                              Container(
                                color: Theme.of(context).colorScheme.background.withOpacity(0.5),
                                child: Center(
                                  child: LoadingAnimationWidget.fourRotatingDots(
                                    color: Theme.of(context).colorScheme.primary,
                                    size: 50,
                                  ),
                                ),
                              )
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _openMessages(BuildContext context) {
    context.push(RoutePath.messages);
  }

  String getMessage(MessageDetail messageDetail, bool isSender) {
    var sender = isSender ? '${S.current.you}: ' : '';
    if (messageDetail.type == MessageType.image) {
      return S.current.send_an_image(sender);
    }
    if (messageDetail.type == MessageType.emoji) {
      return S.current.send_a_emoji(sender);
    }
    return '$sender${messageDetail.message}';
  }

  void _waitHideLastMessage() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showLastMessage = false;
        });
      }
    });
  }

  void _logout() {
    context.read<ConnectBloc>().add(const ConnectReset());
    context.read<RoomsBloc>().add(const RoomsReset());
    context.read<ProfileBloc>().add(const ProfileReset());
    context.read<FriendsBloc>().add(const FriendsReset());
    context.read<HomeBloc>().add(const HomeReset());
    context.go(RoutePath.login);
  }
}
