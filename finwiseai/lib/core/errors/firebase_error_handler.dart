import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHandler {
  FirebaseErrorHandler._();

  static String getMessage(FirebaseAuthException e) {
    return switch (e.code.toLowerCase()) {
      'invalid-email' => 'The email is badly formatted.',
      'user-not-found' => 'No user found for that email.',
      'invalid-credential' => 'Incorrect email or password.',
      'email-already-in-use' => 'This email is already in use.',
      'user-disabled' => 'This user has been disabled.',
      'network-request-failed' =>
        'No internet connection. Please check your connection and try again.',
      'too-many-requests' => 'Too many attempts! Try again later.',
      _ => e.message ?? 'An error occurred.',
    };
  }
}
