import 'dart:convert';
import 'dart:io';

import 'package:codon/utills/api_urls.dart';
import 'package:codon/utills/prefs_service.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

abstract class SettingService {
  Future<Map<String, dynamic>> getAboutUs();

  Future<Map<String, dynamic>> getPrivacyPolicy();

  Future<Map<String, dynamic>> getFaverite();

  Future<Map<String, dynamic>> getTermsConditions();

  Future<Map<String, dynamic>> getHistory();

  Future<Map<String, dynamic>> logout({required String userId});

  Future<Map<String, dynamic>> deleteAccount();

  Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String mobile,
    required String address,
    required String countryId,
    required String stateId,
    required String cityId,
    required String collegeId,
    required String classId,
    required String passingYear,
    File? image,
  });
}

class SettingServiceImpl implements SettingService {
  @override
  Future<Map<String, dynamic>> getAboutUs() async {
    try {
      final response = await http.get(
        headers: {
          'Authorization': 'Bearer ${await PrefsService.getAccessToken()}',
          // ✅ Added colon and comma
        },
        Uri.parse(aboutUsUrl),
      );
      print('About Us Response :- ${response.body}');
      print(response.statusCode);
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'About Us fetched successfully',
          'data': response.body,
        };
      } else {
        return {'success': false, 'message': 'Failed to fetch about us'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to fetch about us'};
    }
  }

  @override
  Future<Map<String, dynamic>> getPrivacyPolicy() async {
    try {
      final response = await http.get(Uri.parse(privacyPolicyUrl));
      print("Privacy Policy Response :- ${response.body}");
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Privacy Policy fetched successfully',
          'data': response.body,
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to fetch terms & conditions',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to fetch privacy policy'};
    }
  }

  @override
  Future<Map<String, dynamic>> getTermsConditions() async {
    try {
      final response = await http.get(Uri.parse(termsConditionsUrl));
      print("Terms & Conditions Response :- ${response.body}");
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Terms & Conditions fetched successfully',
          'data': response.body,
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to fetch terms & conditions',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to fetch terms & conditions',
      };
    }
  }

  @override
  Future<Map<String, dynamic>> getFaverite() async {
    try {
      final response = await http.get(Uri.parse(faveriteUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': 'Faverite fetched successfully',
          'data': data,
        };
      } else {
        return {'success': false, 'message': 'Failed to fetch faverite'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to fetch faverite'};
    }
  }

  @override
  Future<Map<String, dynamic>> getHistory() async {
    try {
      final response = await http.get(Uri.parse(historyUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': 'History fetched successfully',
          'data': data,
        };
      } else {
        return {'success': false, 'message': 'Failed to fetch history'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to fetch history'};
    }
  }

  @override
  Future<Map<String, dynamic>> logout({required String userId}) async {
    try {
      final token = await PrefsService.getAccessToken();
      print("accesss token  :-  ${token}");
      print("user id  :-  ${userId}");
      final response = await http.post(
        headers: {
          'Content-Type': 'application/json', // ✅ Added comma
          'Authorization': 'Bearer $token', // ✅ Added colon and comma
        },
        Uri.parse(logoutUrl),
        body: jsonEncode({'userId': userId}),
      );
      print("Logout Response :- ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Abhi:- logout response: ${response.statusCode}");
        print("Abhi:- logout response: ${response.body}");
        return {
          'success': true,
          'message': 'Logout successfully',
          'data': data,
        };
      } else {
        return {'success': false, 'message': 'Logout Failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Logout Failed'};
    }
  }

  @override
  Future<Map<String, dynamic>> deleteAccount() async {
    try {
      final token = await PrefsService.getAccessToken();
      final response = await http.delete(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        Uri.parse(deleteAccountUrl),
      );
      print("Delete Account Response :- ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': 'Account deleted successfully',
          'data': data,
        };
      } else {
        return {'success': false, 'message': 'Failed to delete account'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to delete account'};
    }
  }

  @override
  Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String mobile,
    required String address,
    required String countryId,
    required String stateId,
    required String cityId,
    required String collegeId,
    required String classId,
    required String passingYear,
    File? image,
  }) async {
    try {
      final token = await PrefsService.getAccessToken();

      print("Full URL being hit: $editProfileUrl");

      var request = http.MultipartRequest('PATCH', Uri.parse(editProfileUrl));

      // Headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      // Fields
      request.fields.addAll({
        'name': name,
        'mobile': mobile,
        'address': address,
        'stateId': stateId,
        'cityId': cityId,
        'collegeName': collegeId, // Using collegeName as per register logic
        'passingYear': passingYear,
      });

      // Image upload logic sahi hai
      if (image != null) {
        final mimeType = lookupMimeType(image.path) ?? 'image/jpeg';
        final mimeSplit = mimeType.split('/');

        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            image.path,
            contentType: MediaType(mimeSplit[0], mimeSplit[1]),
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("Status Code: ${response.statusCode}");
      print("Update profile Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // ⚠️ Resource not found yahan handle hoga
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Catch Error: $e");
      return {'success': false, 'message': 'Update failed: ${e.toString()}'};
    }
  }
}
