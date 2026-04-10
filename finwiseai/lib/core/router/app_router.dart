import 'package:flutter/material.dart';

import '../../features/home/screens/dummy.dart';
import '../../features/auth/screens/login.dart';
import '../../features/auth/screens/signup.dart';
import '../../features/auth/screens/verify_email.dart';

class AppRouter {
  AppRouter._();

  static const String home = '/home_screen';
  static const String login = '/login_screen';
  static const String signup = '/signup_screen';
  static const String verifyEmail = '/verify_email_screen';

  static Map<String, WidgetBuilder> get routes => {
    home: (_) => const DummyScreen(),
    login: (_) => const LoginScreen(),
    signup: (_) => const SignupScreen(),
    verifyEmail: (_) => const VerifyEmailScreen(),
  };
}
