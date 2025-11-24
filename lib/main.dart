import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/dependencies.dart';
import 'routing/router.dart';
import 'data/repositories/person_profile_repository.dart';
import 'data/repositories/appconfig/app_config_repository.dart';
import 'main_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final personProfileRepository = PersonProfileRepository();
  await personProfileRepository.initialize();

  final appConfigRepository = AppConfigRepository();
  await appConfigRepository.initialize();

  runApp(MultiProvider(
    providers: getProviders(personProfileRepository, appConfigRepository),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainAppViewModel>();

    return MaterialApp.router(
      title: 'About Me App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: viewModel.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: createRouter(),
    );
  }
}
