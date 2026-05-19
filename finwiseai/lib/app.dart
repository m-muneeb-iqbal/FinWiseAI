import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'core/constants/app_gradient.dart';
import 'core/constants/app_drawer_theme.dart';
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
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 38, 109, 209), // Darker shade
                Color.fromARGB(255, 144, 179, 233), // Primary theme color
                Color.fromARGB(255, 179, 207, 241), // Lighter shade
              ],
            ),
          ),
          AppDrawerTheme(
            headerDecoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 38, 109, 209),
                  Color.fromARGB(255, 144, 179, 233),
                ],
              ),
            ),
            surfaceColor: Color.fromARGB(255, 238, 238, 241),
            itemColor: Colors.black,
            iconColor: Colors.black,
            accountIconColor: const Color.fromARGB(255, 38, 109, 209),
          ),
        ],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        extensions: [
          AppGradient(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 11, 27, 58), // Darker shade
                Color.fromARGB(255, 22, 59, 115), // Primary theme color
                Color.fromARGB(255, 42, 90, 160), // Lighter shade
              ],
            ),
          ),
          AppDrawerTheme(
            headerDecoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 11, 27, 58),
                  Color.fromARGB(255, 22, 59, 115),
                  Color.fromARGB(255, 42, 90, 160),
                ],
              ),
            ),
            surfaceColor: Color.fromARGB(255, 24, 58, 113),
            itemColor: Colors.white,
            iconColor: Colors.white,
            accountIconColor: Color.fromARGB(255, 11, 27, 58),
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
