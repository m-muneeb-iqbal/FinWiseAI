import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/errors/firebase_error_handler.dart';
import '../../../core/widgets/animated_snack_bar.dart';
import '../../../core/widgets/manual_widgets.dart';
import '../../../core/constants/app_images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _hidePassword = true;
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  void _signIn() async {
    String email = _controllerEmail.text;
    String password = _controllerPassword.text;

    if (email.isEmpty && password.isEmpty) {
      AnimatedSnackBar.show(context, 'Please enter your credentials!');
      return;
    }

    if (email.isEmpty) {
      AnimatedSnackBar.show(context, 'Please enter your email!');
      return;
    }

    if (!email.contains('@')) {
      AnimatedSnackBar.show(context, "Please enter a valid email address!");
      return;
    }

    if (password.isEmpty) {
      AnimatedSnackBar.show(context, 'Please enter the password!');
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;
      AnimatedSnackBar.show(context, 'Logged in successfully!');

      await Future.delayed(const Duration(seconds: 3));

      if (!mounted) return;
      if (userCredential.user != null) {
        Navigator.pushReplacementNamed(context, '/home_screen');
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      AnimatedSnackBar.show(context, FirebaseErrorHandler.getMessage(e));
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = 'An unexpected error occurred. Please try again!';
      });
    }
  }

  Future<bool> _googleLogin() async {
    try {
      final user = await GoogleSignIn().signIn();
      if (user == null) return false;

      final userAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: userAuth.idToken,
        accessToken: userAuth.accessToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      return FirebaseAuth.instance.currentUser != null;
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        AnimatedSnackBar.show(context, FirebaseErrorHandler.getMessage(e));
      }
      return false;
    } catch (e) {
      if (mounted) {
        AnimatedSnackBar.show(
          context,
          'Google sign-in failed. Please try again.',
        );
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,

        decoration: const BoxDecoration(
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

        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ManualWidgets.title(),
                  ManualWidgets.message("Welcome back, you have been missed!"),
                  const SizedBox(height: 20),

                  ManualWidgets.entryField(
                    'Email',
                    _controllerEmail,
                    'Enter your Email',
                    false,
                  ),
                  const SizedBox(height: 20),

                  ManualWidgets.passwordField(
                    title: 'Password',
                    controller: _controllerPassword,
                    placeholder: 'Enter your password',
                    hidePassword: _hidePassword,
                    onToggleVisibility: () {
                      setState(() {
                        _hidePassword = !_hidePassword;
                      });
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ManualWidgets.labelButton(
                        text: 'Forgot Password?',
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/forgot_password_screen',
                          );
                        },
                      ),
                    ],
                  ),

                  ManualWidgets.loginRegisterButton('Login', _signIn),
                  const SizedBox(height: 20),
                  Divider(color: Colors.white),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ManualWidgets.associatedLoginButton(
                        onTap: () async {
                          bool isLogged = await _googleLogin();
                          if (isLogged && context.mounted) {
                            Navigator.pushReplacementNamed(
                              context,
                              '/home_screen',
                            );
                          }
                        },

                        imageAsset: Images.google,
                      ),
                      const SizedBox(width: 10),

                      ManualWidgets.associatedLoginButton(
                        onTap: () {},
                        imageAsset: Images.github,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  ManualWidgets.labelButton(
                    text: 'Not a User? Register Now!',
                    onPressed: () =>
                        Navigator.pushNamed(context, '/signup_screen'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
