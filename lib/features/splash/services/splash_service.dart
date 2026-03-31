import 'dart:convert';

import 'package:codon/utills/api_urls.dart';
import 'package:codon/utills/prefs_service.dart';
import 'package:http/http.dart' as http;

import '../../../utills/base_api_client.dart';

abstract class SplashService {
  Future<Map<String, dynamic>> authCheck();
  Future<Map<String, dynamic>> checkServerStatus();
}

class SplashServiceImpl implements SplashService {
  @override
  Future<Map<String, dynamic>> authCheck() async {
    try {
      final token = await PrefsService.getAccessToken();
      BaseApiClient.accessToken = token;
      print("Token :- $token");
      final response = await http.get(
        headers: {'Authorization': 'Bearer $token'},
        Uri.parse(authMeUrl),
      );
      print("Auth Check Response: ${response.body}");
      print("Auth Check Status Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        return {'success': false, 'message': 'User not found'};
      } else {
        return {'success': false, 'message': 'Failed to fetch auth check'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to fetch auth check'};
    }
  }

  Future<Map<String, dynamic>> checkServerStatus() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      print("Server Status Response: ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'success': false, 'message': 'Failed to fetch server status'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to fetch server status'};
    }
  }
}