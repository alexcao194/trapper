import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trapper/app/presentation/bloc/auth/auth_bloc.dart';
import 'package:trapper/app/presentation/screen/login_screen.dart';
import 'package:trapper/app/presentation/screen/messages_screen.dart';

class AppGoRouter {
  static get router => GoRouter(
    redirect: (context, state) {
      if(RoutePath.publicPaths.contains(state.path)) {
        return null;
      }
      if (context.read<AuthBloc>().state is AuthStateAuthenticated) {
        return null;
      }
      return null;
      return RoutePath.login;
    },
    routes: [
      GoRoute(
        path: RoutePath.login,
        pageBuilder: (context, state) => const MaterialPage(child: LoginScreen()),
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
  static const String signUp = '/sign-up';
  static const String profile = '/profile';
  static const String messages = '/';
  static const String settings = '/settings';

  static const publicPaths = [
    login,
    signUp,
  ];
}