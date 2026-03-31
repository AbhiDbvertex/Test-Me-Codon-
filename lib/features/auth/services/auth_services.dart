import 'dart:convert';
import 'package:codon/utills/api_urls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

abstract class AuthService {
  Future<Map<String, dynamic>> login({
    required String emailOrPhone,
    required String password,
  });
  Future<Map<String, dynamic>> register({
    required String name,
    required String emailOrPhone,
    required String password,
    required String mobile,
    required String address,
    // required String countryId,
    required String stateId,
    required String cityId,
    required String collegeName,
    String? classId,
    required String admissionYear,
  });
  Future<Map<String, dynamic>> forgotPassword({required String email});
  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });
  Future<Map<String, dynamic>> verifyEmail({
    required String email,
    required String otp,
    required String password,
  });
  Future<Map<String, dynamic>> logout({
    required String token,
    required String userId,
  });
  Future<Map<String, dynamic>> verifyUser({required String token});
  Future<Map<String, dynamic>> resendOtpForEmailVerification({
    required String email,
  });
  Future<Map<String, dynamic>> googleAuth({required String idToken});
  Future<Map<String, dynamic>> authMe({required String token});
}

/// AuthServiceImpl
class AuthServiceImpl implements AuthService {
  /// Login
  @override
  Future<Map<String, dynamic>> login({
    required String emailOrPhone,
    required String password,
  }) async {
    final url = Uri.parse(emailLoginUrl);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        emailOrPhone.isEmail ? 'email' : 'mobile': emailOrPhone,
        'password': password,
      }),
    );
    print("Login response  :- ${response.body}");
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  /// Register
  @override
  Future<Map<String, dynamic>> register({
    required String name,
    required String emailOrPhone,
    required String password,
    required String mobile,
    required String address,
    // required String countryId,
    required String stateId,
    required String cityId,
    required String collegeName,
    String? classId,
    required String admissionYear,
  }) async {
    final url = Uri.parse(registerUrl);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "email": emailOrPhone,
        "password": password,
        "mobile": mobile,
        "address": address,
        // "countryId": countryId,
        "stateId": stateId,
        "cityId": cityId,
        "collegeName": collegeName,
        // "classId": classId ?? "",
        "passingYear": admissionYear,
      }),
    );
    print("Register response  :- ${response.body}");
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  /// Verify Email
  @override
  Future<Map<String, dynamic>> verifyEmail({
    required String email,
    required String otp,
    required String password,
  }) async {
    final url = Uri.parse(verifyEmailUrl);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = {'success': true, "message": 'Email verifyed sucessfully'};
      return data;
    } else {
      final data = {'success': true, "message": 'Email verification Failed'};
      return data;
    }
  }

  @override
  Future<Map<String, dynamic>> forgotPassword({required String email}) async {
    final url = Uri.parse(forgotPasswordUrl);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    String serverMessage = "";
    try {
      final responseData = jsonDecode(response.body);
      serverMessage =
          responseData['message'] ?? responseData['error'] ?? response.body;
    } catch (e) {
      serverMessage = response.body;
    }
    print("Forgot Password response  :- ${response.body}");
    print("Forgot Password status code  :- ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = {
        'success': true,
        'message': serverMessage.isEmpty
            ? 'OTP sent successfully'
            : serverMessage,
      };
      return data;
    } /*else if (response.statusCode == 429) {
      final data = {
        'success': false,
        'message': 'Too many requests. Please try again later.',
      };
      return data;
    }*/ else {
      final data = {
        'success': false,
        'message': serverMessage.isEmpty
            ? 'Something went wrong'
            : serverMessage,
      };
      return data;
    }
  }

  /// Reset Password
  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    final url = Uri.parse(resetPasswordUrl);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "otp": otp,
        "newPassword": newPassword,
      }),
    );
    print("Reset Password response  :- ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = {'success': true, 'message': 'Password reset successfully'};
      return data;
    } else if (response.body ==
        "Too many OTP requests, try again later after 10 minutes") {
      final data = {'success': false, 'message': response.body ?? ""};
      return data;
    } else {
      final data = {'success': false, 'message': 'Failed to reset password.'};
      return data;
    }
  }

  /// logout
  Future<Map<String, dynamic>> logout({
    required String token,
    required String userId,
  }) async {
    print("Logout token :- $token");
    print("Logout userId :- $userId");
    final url = Uri.parse(logoutUrl);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'userId': userId}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  @override
  Future<Map<String, dynamic>> resendOtpForEmailVerification({
    required String email,
  }) async {
    final url = Uri.parse(resendOtpUrl);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    final responseData = jsonDecode(response.body);
    print("Resend OTP for email verification response  :- ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = {'success': true, 'message': 'OTP sent successfully'};
      return data;
    } else {
      final data = {
        'success': false,
        'message': responseData["message"] ?? 'Failed to send OTP',
      };
      return data;
    }
  }

  ///verify user
  Future<Map<String, dynamic>> verifyUser({required String token}) async {
    final url = Uri.parse(verifyUserUrl);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  /// Google Authentication
  @override
  Future<Map<String, dynamic>> googleAuth({required String idToken}) async {
    final user = FirebaseAuth.instance.currentUser;
    final firebaseIdToken = await user!.getIdToken();
    final url = Uri.parse(googleAuthUrl);
    debugPrint("Google Auth idToken: $firebaseIdToken");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': firebaseIdToken}),
    );
    debugPrint("Google Auth response: ${response.body}");
    final responseData = jsonDecode(response.body);
    debugPrint("dhdjkddjiojd ${responseData['activeSubscription']}");
    print("Google Auth status code: ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  @override
  Future<Map<String, dynamic>> authMe({required String token}) async {
    final url = Uri.parse(authMeUrl);
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }
}
