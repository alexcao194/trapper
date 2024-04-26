import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/presentation/bloc/auth/auth_bloc.dart';
import '../../app/presentation/screen/home/home_screen.dart';
import '../../app/presentation/screen/login/login_screen.dart';
import '../../app/presentation/screen/rooms/messages_screen.dart';

class AppGoRouter {
  static get router => GoRouter(
    initialLocation: RoutePath.home,
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      if (authState is! AuthStateAuthenticated) {
        if (!RoutePath.publicPaths.contains(state.matchedLocation)) {
          return RoutePath.login;
        }
        return null;
      } else {
        if (RoutePath.publicPaths.contains(state.matchedLocation) || state.matchedLocation == RoutePath.initial) {
          return RoutePath.home;
        } else if (!RoutePath.validRoutes.contains(state.matchedLocation)) {
          return RoutePath.invalidRoute;
        }
        return null;
      }
    },
    routes: [
      GoRoute(
        path: RoutePath.login,
        pageBuilder: (context, state) => buildCustomTransitionPage(
          child: const LoginScreen(),
          context: context,
          state: state,
        ),
      ),
      GoRoute(
        path: RoutePath.home,
        pageBuilder: (context, state) => buildCustomTransitionPage(
          child: const HomeScreen(),
          context: context,
          state: state,
        ),
      ),
      GoRoute(
        path: RoutePath.messages,
        pageBuilder: (context, state) => buildCustomTransitionPage(
          child: const MessageScreen(),
          context: context,
          state: state,
        ),
      ),
      GoRoute(
        path: RoutePath.invalidRoute,
        pageBuilder: (context, state) => buildCustomTransitionPage(
          child: const Scaffold(
            body: Center(
              child: Text('404 Not Found'),
            ),
          ),
          context: context,
          state: state,
        ),
      ),
    ],
  );
}

class RoutePath {
  const RoutePath._();
  static const initial = '/';
  static const String login = '/auth/login';
  static const String home = '/home';
  static const String messages = '/message';
  static const String invalidRoute = '/404';

  static const publicPaths = [
    login,
  ];

  static const validRoutes = [
    initial,
    home,
    messages,
    login,
  ];
}

CustomTransitionPage buildCustomTransitionPage<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(key: state.pageKey, child: child, transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child));
}
