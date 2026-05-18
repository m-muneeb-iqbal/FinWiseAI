import 'package:flutter/material.dart';

import '../../features/home/screens/home.dart';
import '../../features/auth/screens/login.dart';
import '../../features/auth/screens/forgot_password.dart';
import '../../features/auth/screens/signup.dart';
import '../../features/auth/screens/verify_email.dart';
import '../../features/home/screens/profile.dart';
import '../../features/home/screens/add_expense.dart';
import '../../features/home/screens/savings_plan.dart';

class AppRouter {
  AppRouter._();

  static const String home = '/home_screen';
  static const String login = '/login_screen';
  static const String signup = '/signup_screen';
  static const String forgotPassword = '/forgot_password_screen';
  static const String verifyEmail = '/verify_email_screen';
  static const String profile = '/profile_screen';
  static const String addExpense = '/add_expense_screen';
  static const String savingsPlan = '/savings_plan_screen';

  static Map<String, WidgetBuilder> get routes => {
    home: (_) => const HomeScreen(),
    login: (_) => const LoginScreen(),
    signup: (_) => const SignupScreen(),
    forgotPassword: (_) => const ForgotPasswordScreen(),
    verifyEmail: (_) => const VerifyEmailScreen(),
    profile: (_) => const ProfileScreen(),
    addExpense: (_) => const AddExpenseScreen(),
    savingsPlan: (_) => const SavingsPlanScreen(),
  };
}
