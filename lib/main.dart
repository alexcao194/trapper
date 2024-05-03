import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/presentation/bloc/auth/auth_bloc.dart';
import 'app/presentation/bloc/connect/connect_bloc.dart';
import 'app/presentation/bloc/friends/friends_bloc.dart';
import 'app/presentation/bloc/home/home_bloc.dart';
import 'app/presentation/bloc/profile/profile_bloc.dart';
import 'app/presentation/bloc/rooms/rooms_bloc.dart';
import 'app/presentation/bloc/settings/settings_bloc.dart';
import 'app/presentation/bloc/sticker/sticker_bloc.dart';
import 'config/const/app_colors.dart';
import 'config/database/hive_tools.dart';
import 'config/dio/dio_tools.dart';
import 'config/go_router/app_go_router.dart';
import 'generated/l10n.dart';
import 'di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveTools.init();
  DioTools.init();
  await DependencyInjection.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => DependencyInjection.sl<AuthBloc>()),
        BlocProvider<SettingsBloc>(create: (context) => DependencyInjection.sl<SettingsBloc>()),
        BlocProvider<ProfileBloc>(create: (context) => DependencyInjection.sl<ProfileBloc>()),
        BlocProvider<RoomsBloc>(create: (context) => DependencyInjection.sl<RoomsBloc>()),
        BlocProvider<ConnectBloc>(create: (context) => DependencyInjection.sl<ConnectBloc>()),
        BlocProvider<FriendsBloc>(create: (context) => DependencyInjection.sl<FriendsBloc>()),
        BlocProvider<HomeBloc>(create: (context) => DependencyInjection.sl<HomeBloc>()),
        BlocProvider<StickerBloc>(create: (context) => DependencyInjection.sl<StickerBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (previous, current) => previous.settingsSnapshot != current.settingsSnapshot,
      builder: (context, state) {
        var colorScheme = ColorScheme.fromSeed(
          seedColor: state.settingsSnapshot.themeIndex == 0 ? Color.fromARGB(255, state.settingsSnapshot.red, state.settingsSnapshot.green, state.settingsSnapshot.blue) : AppColors.seeks[state.settingsSnapshot.themeIndex - 1],
        );
        return MaterialApp.router(
          routerConfig: AppGoRouter.router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData.from(colorScheme: colorScheme).copyWith(brightness: Brightness.light),
          darkTheme: ThemeData.dark(),
          localizationsDelegates: [
            S.delegate..load(Locale(state.languageCode)),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
