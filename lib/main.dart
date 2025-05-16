import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';
import 'screens/form_screen.dart';
import 'screens/calculator_screen.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.currentTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/form': (context) => const FormScreen(),
        '/calculator': (context) => const CalculatorScreen(),
        '/game': (context) => const GameScreen(),
      },
    );
  }
}
