import 'package:bookit/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookit/screens/login_screen.dart';
import 'package:bookit/screens/signup_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String signup = '/signup';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignupScreen(),
  };
}
