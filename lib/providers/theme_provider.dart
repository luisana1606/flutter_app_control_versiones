import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;

  ThemeData get currentTheme => _isDark ? _darkTheme : _lightTheme;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  static final _lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white.withOpacity(0.95),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromARGB(200, 240, 255, 255),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF00BFAE),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );

  static final _darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.cyan,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF101820).withOpacity(0.98),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromARGB(180, 20, 30, 40),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF101820),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
}
