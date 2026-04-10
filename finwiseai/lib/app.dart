import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'core/router/app_router.dart';
import 'features/home/screens/dummy.dart';
import 'features/auth/screens/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FinWiseAI',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return snapshot.hasData ? const DummyScreen() : const LoginScreen();
        },
      ),
      routes: AppRouter.routes,
    );
  }
}
