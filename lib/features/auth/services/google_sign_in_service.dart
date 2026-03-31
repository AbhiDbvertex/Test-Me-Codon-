import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class GoogleSignInService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Sign in with Google
  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        return {'success': false, 'message': 'Sign-in cancelled by user'};
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      final User? user = userCredential.user;
      debugPrint("User: ${googleAuth.accessToken}");

      if (user != null) {
        return {
          'success': true,
          'message': 'Sign-in successful',
          'user': {
            'uid': user.uid,
            'email': user.email,
            'displayName': user.displayName,
            'photoURL': user.photoURL,
            'phoneNumber': user.phoneNumber,
          },
          'idToken': await user.getIdToken(),
        };
      } else {
        return {'success': false, 'message': 'Failed to get user data'};
      }
    } on FirebaseAuthException catch (e) {
      return {
        'success': false,
        'message': _getFirebaseErrorMessage(e.code),
        'errorCode': e.code,
      };
    } catch (e) {
      print("Error: $e");
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }

  /// Sign out from Google and Firebase
  Future<void> signOut() async {
    try {
      await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  /// Check if user is currently signed in
  bool isSignedIn() {
    return _auth.currentUser != null;
  }

  /// Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Get user-friendly error messages
  String _getFirebaseErrorMessage(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials.';
      case 'invalid-credential':
        return 'The credential is malformed or has expired.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled. Please contact support.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found with this credential.';
      case 'wrong-password':
        return 'Invalid password.';
      case 'invalid-verification-code':
        return 'Invalid verification code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
