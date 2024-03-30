import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trapper/app/presentation/bloc/auth/auth_bloc.dart';
import 'package:trapper/app/presentation/screen/home/home_screen.dart';
import 'package:trapper/app/presentation/screen/login/login_screen.dart';
import 'package:trapper/app/presentation/screen/rooms/messages_screen.dart';

import '../../app/presentation/screen/home/home_tabs/connect_tab.dart';
import '../../app/presentation/screen/home/home_tabs/friends_tab.dart';
import '../../app/presentation/screen/home/home_tabs/help_tab.dart';
import '../../app/presentation/screen/home/home_tabs/profile_tab.dart';
import '../../app/presentation/screen/home/home_tabs/settings_tab.dart';

class AppGoRouter {
  static get router => GoRouter(
        initialLocation: RoutePath.login,
        redirect: (context, state) {
          final authState = context.read<AuthBloc>().state;
          if (authState is! AuthStateAuthenticated) {
            if (!RoutePath.publicPaths.contains(state.path)) {
              return RoutePath.login;
            }
            return null;
          } else {
            if (RoutePath.publicPaths.contains(state.path)) {
              return RoutePath.home;
            }
            return null;
          }
        },
        routes: [
          GoRoute(
            path: RoutePath.login,
            pageBuilder: (context, state) => const MaterialPage(child: LoginScreen()),
          ),
          GoRoute(
            path: RoutePath.home,
            pageBuilder: (context, state) => const MaterialPage(child: HomeScreen()),
            routes: [
              GoRoute(
                path: RoutePath.profile,
                pageBuilder: (context, state) => const MaterialPage(child: ProfileTab()),
              ),
              GoRoute(
                path: RoutePath.friends,
                pageBuilder: (context, state) => const MaterialPage(child: FriendsTab()),
              ),
              GoRoute(
                path: RoutePath.settings,
                pageBuilder: (context, state) => const MaterialPage(child: SettingsTab()),
              ),
              GoRoute(
                path: RoutePath.connect,
                pageBuilder: (context, state) => const MaterialPage(child: ConnectTab()),
              ),
              GoRoute(
                path: RoutePath.help,
                pageBuilder: (context, state) => const MaterialPage(child: HelpTab()),
              ),
            ],
          ),
          GoRoute(
            path: RoutePath.messages,
            pageBuilder: (context, state) => const MaterialPage(child: MessageScreen()),
          ),
        ],
      );
}

class RoutePath {
  static const String login = '/login';
  static const String home = '/home';
  static const String messages = '/message';
  static const String signUp = '/sign-up';

  static const String profile = 'profile';
  static const String settings = 'settings';
  static const String friends = 'friends';
  static const String connect = 'connect';
  static const String help = 'help';

  static const List<String> homeTabs = [
    profile,
    friends,
    connect,
    settings,
    help,
  ];

  static const publicPaths = [
    login,
    signUp,
  ];

  static join(List<String> paths) {
    return "/${paths.join('/')}";
  }
}
