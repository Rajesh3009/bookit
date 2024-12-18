import 'package:bookit/screens/export.dart';
import 'package:bookit/widgets/auth_wrapper.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String authWrapper = '/';
  static const String booking = '/booking';
  static const String movieDetailPage = '/detail';
  static const String editProfile = '/editProfile'; // Add the new route

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignupScreen(),
    authWrapper: (context) => const AuthWrapper(),
    editProfile: (context) =>
        const EditProfileScreen(), // Add the new route mapping
  };
}
