import 'package:bookit/routes/routes.dart';
import 'package:bookit/themes/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/export.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bookit',
      theme: orangeTheme,
      initialRoute: Routes.login, // Set initial route
      routes: {
        Routes.login: (context) => const LoginScreen(),
        Routes.signup: (context) => const SignupScreen(),
        Routes.home: (context) => const HomeScreen(),
        // Add more routes here as needed
      },
    );
  }
}
