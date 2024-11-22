import 'package:bookit/screens/home_screen.dart';
import 'package:bookit/screens/login_screen.dart';
import 'package:bookit/screens/signup_screen.dart';
import 'package:bookit/widgets/auth_wrapper.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String authWrapper = '/';
  static const String booking = '/booking';
  static const String movieDetailPage = '/detail';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignupScreen(),
    authWrapper: (context) => const AuthWrapper(),
  };
}
