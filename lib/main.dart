// import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'state/user_settings_state.dart';

// app entry point
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserSettingsState(),
      child: const MyApp(),
    ),
  );
}

// define MyApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainPage());
  }
}
  // create compile-time constant 

  // define build method 