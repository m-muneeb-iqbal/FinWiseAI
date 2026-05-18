import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/router/app_router.dart';
import '../../../core/widgets/animated_snack_bar.dart';
import '../../../core/widgets/manual_widgets.dart';
import '../../../firebase_options.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final _controllerEmail = TextEditingController();
  bool _isLoading = false;

  Future<List<String>> _fetchSignInMethodsForEmail(String email) async {
    final response = await http.post(
      Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:createAuthUri?key=${DefaultFirebaseOptions.currentPlatform.apiKey}',
      ),
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({
        'identifier': email,
        'continueUri': 'http://localhost',
      }),
    );

    if (response.statusCode != 200) {
      throw FirebaseAuthException(
        code: 'network-request-failed',
        message: 'Unable to verify the sign-in method for this email.',
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final methods = <String>{
      ...?((data['signInMethods'] as List?)?.cast<String>()),
      ...?((data['signinMethods'] as List?)?.cast<String>()),
      ...?((data['allProviders'] as List?)?.cast<String>()),
    };

    return methods.toList();
  }

  Future <void> _resetPassword(BuildContext context) async{

    String email = _controllerEmail.text.trim();

    try {
      
      if(email.isEmpty) {
        AnimatedSnackBar.show(context, 'Please enter your email!');
        return;
      }

      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }

      final signInMethods = await _fetchSignInMethodsForEmail(email);

      if (signInMethods.isEmpty) {
        if (context.mounted) {
          AnimatedSnackBar.show(
            context,
            'We could not find an account with that email address.',
          );
        }
        return;
      }

      if (!signInMethods.contains('password')) {
        if (context.mounted) {
          AnimatedSnackBar.show(
            context,
            'This email is linked to Google Sign-In, so password reset is not available. We will take you back to login.',
          );

          await Future.delayed(const Duration(seconds: 2));

          if (context.mounted) {
            Navigator.pushReplacementNamed(context, AppRouter.login);
          }
        }
        return;
      }

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      AnimatedSnackBar.show(context, 'If this email is registered, a reset link has been sent to: $email');

    } on FirebaseAuthException catch (e) {

      String errorMessage = 'An error occurred';
      final code = e.code.toLowerCase();

      switch (code) {

        case 'invalid-email':
          errorMessage = 'The email is badly formatted!';
          break;

        case 'user-not-found':
          errorMessage = 'No user found for that email!';
          break;

        case 'network-request-failed':
          errorMessage = 'No internet connection. Please check your connection and try again!';
          break;

        case 'too-many-requests':
          errorMessage = 'Too many attempts! Try again later.';
          break;

        default:
          errorMessage = e.message ?? errorMessage;

      }

      if (context.mounted) {
        AnimatedSnackBar.show(context, errorMessage);
      }
      
    } 
    finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }

    return;
  }

  @override
  void dispose () {
    _controllerEmail.dispose();
    super.dispose();
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

          )
        ),

        child: SafeArea(

          child: Stack(

            children: [

              Positioned(

                top: 10,
                left: 10,

                child: IconButton(

                  onPressed: () => Navigator.pop(context), 
                  icon: Icon(
                    Icons.arrow_back, 
                    color: Colors.white,
                    size: 25,
                  )

                )
              ),
              Center(

                child: Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 20),

                  child: Column(

                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      ManualWidgets.title(),
                      const SizedBox(height: 40),
                      ManualWidgets.message("Smart Finance - Forgot Password"),
                      const SizedBox(height: 40),

                      ManualWidgets.entryField(
                        'Email',
                        _controllerEmail, 
                        'Enter your Email', 
                        false
                      ),
                      const SizedBox(height: 20),
                      ManualWidgets.sendButton(
                        text: 'Forgot Password',
                        width: MediaQuery.of(context).size.width * 1, // or just any width you want
                        isLoading: _isLoading,
                        onPressed: () => _resetPassword(context),
                      )

                    ],

                  ),

                ),

              )

            ],

          )

        ),

      ),

    );

  }
  
}