import 'package:bookit/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookit/views/homeview.dart';
import 'package:bookit/screens/login_screen.dart';
import 'package:bookit/screens/signup_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String signup = '/signup';

  static Map<String, Widget Function(BuildContext)> get routes => {
        login: (context) => _guardAuth(const LoginScreen()),
        signup: (context) => _guardAuth(const SignupScreen()),
        home: (context) => _guardAuth(const HomeScreen(), requireAuth: true),
      };

  static Widget _guardAuth(Widget child, {bool requireAuth = false}) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData && !requireAuth) {
          return const HomeScreen();
        }
        if (!snapshot.hasData && requireAuth) {
          return const LoginScreen();
        }
        return child;
      },
    );
  }
}
