import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zikr_app/core/di/injection_container.dart' as di;
import 'package:zikr_app/core/navigation/navigation_service.dart';
import 'package:zikr_app/core/navigation/route_generator.dart';
import 'package:zikr_app/core/notifications/notification_service.dart';
import 'package:zikr_app/core/theme/app_theme.dart';
import 'package:zikr_app/core/shell/app_shell.dart';
import 'package:zikr_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:zikr_app/features/settings/presentation/cubit/settings_state.dart';
import 'package:zikr_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:zikr_app/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initCore();
  await di.sl<NotificationService>().init();
  runApp(const ZikrApp());
}

class ZikrApp extends StatelessWidget {
  const ZikrApp({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = di.sl<NavigationService>();
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<SettingsCubit>()..loadSettings()),
        BlocProvider(create: (_) => di.sl<AuthCubit>()..checkAuthStatus()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          final locale = Locale(settingsState.settings.language);
          return MaterialApp(
            title: 'Zikr',
            locale: locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar'),
              Locale('en'),
            ],
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: settingsState.settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            navigatorKey: nav.navigatorKey,
            onGenerateRoute: generateRoute,
            initialRoute: '/splash',
            home: const AppShell(),
          );
        },
      ),
    );
  }
}
