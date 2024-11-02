import 'package:flutter/material.dart';

final ThemeData orangeTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.orange,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.orange,
  ).copyWith(
    secondary: Colors.deepOrangeAccent, // This replaces 'accentColor'
  ),
  scaffoldBackgroundColor: Colors.orange.shade50,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.orange,
    textTheme: ButtonTextTheme.primary,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.orange,
  ),
  textTheme: TextTheme(
    bodyLarge:
        TextStyle(color: Colors.orange.shade900), // Changed from bodyText1
    bodyMedium:
        TextStyle(color: Colors.orange.shade800), // Changed from bodyText2
    displayLarge:
        TextStyle(color: Colors.orange.shade700), // Changed from headline1
  ),
);
