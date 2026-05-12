import 'package:flutter/material.dart';

import '../../features/home/screens/home.dart';
import '../../features/auth/screens/login.dart';
import '../../features/auth/screens/forgot_password.dart';
import '../../features/auth/screens/signup.dart';
import '../../features/auth/screens/verify_email.dart';

class AppRouter {
  AppRouter._();

  static const String home = '/home_screen';
  static const String login = '/login_screen';
  static const String signup = '/signup_screen';
  static const String forgotPassword = '/forgot_password_screen';
  static const String verifyEmail = '/verify_email_screen';

  static Map<String, WidgetBuilder> get routes => {
    home: (_) => const HomeScreen(),
    login: (_) => const LoginScreen(),
    signup: (_) => const SignupScreen(),
    forgotPassword: (_) => const ForgotPasswordScreen(),
    verifyEmail: (_) => const VerifyEmailScreen(),
  };
}
