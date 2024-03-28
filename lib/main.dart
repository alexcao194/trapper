import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trapper/app/presentation/bloc/settings/settings_bloc.dart';
import 'package:trapper/config/const/app_colors.dart';
import 'app/presentation/bloc/auth/auth_bloc.dart';
import 'config/go_router/app_go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => DependencyInjection.sl<AuthBloc>()),
        BlocProvider<SettingsBloc>(create: (context) => DependencyInjection.sl<SettingsBloc>()),
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
          theme: ThemeData.light().copyWith(colorScheme: colorScheme),
          darkTheme: ThemeData.dark().copyWith(colorScheme: colorScheme),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('vi', 'VN'),
            Locale('en', 'US'),
          ],
        );
      },
    );
  }
}
