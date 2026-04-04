import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'services/local_storage_service.dart';
import 'services/quiz_repository.dart';
import 'utils/app_theme.dart';
import 'viewmodels/quiz_view_model.dart';
import 'viewmodels/settings_view_model.dart';

class BrainBoostApp extends StatelessWidget {
  const BrainBoostApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = LocalStorageService();
    final repository = const QuizRepository();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsViewModel(storage)..initialize(),
        ),
        ChangeNotifierProvider(
          create: (_) => QuizViewModel(repository, storage)..initialize(),
        ),
      ],
      child: Consumer<SettingsViewModel>(
        builder: (context, settings, _) {
          if (!settings.initialized) {
            return const MaterialApp(home: Scaffold());
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Brain Boost Quiz',
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(nextScreen: HomeScreen()),
          );
        },
      ),
    );
  }
}
