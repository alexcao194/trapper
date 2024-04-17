import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/presentation/bloc/auth/auth_bloc.dart';
import '../../app/presentation/screen/home/home_screen.dart';
import '../../app/presentation/screen/login/login_screen.dart';
import '../../app/presentation/screen/rooms/messages_screen.dart';

class AppGoRouter {
  static get router => GoRouter(
        initialLocation: RoutePath.home,
        routes: [
          GoRoute(
            path: RoutePath.login,
            pageBuilder: (context, state) => const MaterialPage(child: LoginScreen()),
          ),
          GoRoute(
            path: RoutePath.home,
            pageBuilder: (context, state) => const MaterialPage(child: HomeScreen()),
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
  static const String home = '/';
  static const String messages = '/message';

  static const publicPaths = [
    login,
  ];
}
