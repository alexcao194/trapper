import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trapper/app/presentation/bloc/auth/auth_bloc.dart';
import 'package:trapper/app/presentation/screen/home_screen.dart';
import 'package:trapper/app/presentation/screen/login_screen.dart';
import 'package:trapper/app/presentation/screen/messages_screen.dart';

class AppGoRouter {
  static get router => GoRouter(
        redirect: (context, state) {
          if (RoutePath.publicPaths.contains(state.path)) {
            return null;
          }
          if (context.read<AuthBloc>().state is AuthStateAuthenticated) {
            if (RoutePath.publicPaths.contains(state.path)) {
              return RoutePath.home;
            }
            return null;
          }
          return null;
          return RoutePath.login;
        },
        routes: [
          GoRoute(
            path: "/${RoutePath.login}",
            pageBuilder: (context, state) => const MaterialPage(child: LoginScreen()),
          ),
          GoRoute(
            path: "/${RoutePath.home}",
            pageBuilder: (context, state) => const MaterialPage(child: HomeScreen()),
            routes: [
              GoRoute(
                path: RoutePath.messages,
                name: RoutePath.messages,
                pageBuilder: (context, state) => const MaterialPage(child: MessageScreen()),
              ),
            ],
          ),
        ],
      );
}

class RoutePath {
  static const String login = '';
  static const String home = 'home';
  static const String signUp = 'sign-up';
  static const String profile = 'profile';
  static const String messages = 'message';
  static const String settings = 'settings';

  static const publicPaths = [
    login,
    signUp,
  ];

  static join(List<String> paths) {
    return "/${paths.join('/')}";
  }
}
