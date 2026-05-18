import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'core/constants/app_gradient.dart';
import 'core/router/app_router.dart';
import 'features/home/screens/home.dart';
import 'features/auth/screens/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FinWiseAI',
      theme: ThemeData(
        brightness: Brightness.light,
        extensions: [
          AppGradient(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF266DD1), // Darker shade
                Color(0xFF90B3E9), // Primary theme color
                Color(0xFFB3CFF1), // Lighter shade
              ],
            ),
          ),
        ],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        extensions: [
          AppGradient(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0A1F4D), // Darker shade
                Color(0xFF1A3A7A), // Primary theme color
                Color(0xFF2A5299), // Lighter shade
              ],
            ),
          ),
        ],
      ),
      themeMode: ThemeMode.system,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return snapshot.hasData ? const HomeScreen() : const LoginScreen();
        },
      ),
      routes: AppRouter.routes,
    );
  }
}
