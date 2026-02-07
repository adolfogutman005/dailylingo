// import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'state/user_settings_state.dart';
import 'data/database/app_database.dart';
import 'services/vocabulary_service.dart';

// app entry point
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserSettingsState()),
        Provider<AppDatabase>(
          create: (_) => AppDatabase(),
          dispose: (_, db) => db.close(), // optional: closes DB when app exits
        ),
        ProxyProvider<AppDatabase, VocabularyService>(
          update: (_, db, __) => VocabularyService(db),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

// define MyApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}
