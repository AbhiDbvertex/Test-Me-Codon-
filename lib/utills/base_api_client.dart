import 'dart:async';
import 'dart:convert';
import 'dart:io'; // Necessary for SocketException

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class BaseApiClient {
  static final BaseApiClient _instance = BaseApiClient._internal();

  factory BaseApiClient() => _instance;

  BaseApiClient._internal();

  final http.Client _client = http.Client();
  static String? accessToken;
  final Duration _timeoutDuration = const Duration(seconds: 30);

  void _prettyLogRequest(String method, String url, dynamic body, Map headers) {
    if (kDebugMode) {
      print("╔═══════════ 🚀 API REQUEST ═══════════╗");
      print("║ 🛰️ METHOD  : $method");
      print("║ 🔗 URL     : $url");
      print("║ 🔑 HEADERS : $headers");
      if (body != null) print("║ 📦 BODY    : ${jsonEncode(body)}");
      print("╚═══════════════════════════════════════╝");
    }
  }

  void _prettyLogResponse(int statusCode, dynamic body) {
    if (kDebugMode) {
      print("╔═══════════ ✅ API RESPONSE ══════════╗");
      print("║ 📑 STATUS  : $statusCode");
      print("║ 📄 BODY    : $body");
      print("╚═══════════════════════════════════════╝");
    }
  }

  // --- HEADERS ---
  Map<String, String> _getHeaders() => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (accessToken != null && accessToken!.isNotEmpty) 'Authorization': 'Bearer $accessToken',
  };

  Future<Map<String, dynamic>> call({
    required String url,
    required String method,
    Map<String, String>? queryParams,
    dynamic body,
  }) async {
    Uri uri = Uri.parse(url);
    if (queryParams != null) {
      uri = uri.replace(queryParameters: queryParams);
    }

    final headers = _getHeaders();
    _prettyLogRequest(method, uri.toString(), body, headers);

    try {
      http.Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          response = await _client
              .get(uri, headers: headers)
              .timeout(_timeoutDuration);
          break;
        case 'POST':
          response = await _client
              .post(uri, headers: headers, body: body==null?jsonEncode({}):jsonEncode(body))
              .timeout(_timeoutDuration);
          break;
        case 'PUT':
          response = await _client
              .put(uri, headers: headers, body: jsonEncode(body))
              .timeout(_timeoutDuration);
          break;
        // case 'DELETE':
        //   response = await _client
        //       .delete(uri, headers: headers, body: jsonEncode(body))
        //       .timeout(_timeoutDuration);
        //   break;

        case 'DELETE':
          response = await _client
              .delete(uri, headers: headers, body: body != null ? jsonEncode(body) : null)
              .timeout(_timeoutDuration);
          break;
        default:
          throw Exception("Method $method not supported");
      }

      return _handleResponse(response);
    } on TimeoutException {
      return {
        'success': false,
        'message': 'The server is taking too long to respond.',
      };
    } on SocketException {
      return {
        'success': false,
        'message': 'No internet connection. Please check your network.',
      };
    } on http.ClientException {
      return {
        'success': false,
        'message': 'Communication error with the server.',
      };
    } catch (e) {
      if (kDebugMode) print("❌ Unexpected Error: $e");
      return {
        'success': false,
        'message': 'Something went wrong. Please try again later.',
      };
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    _prettyLogResponse(response.statusCode, response.body);

    try {
      final decodedBody = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decodedBody;
      }
      else if (response.statusCode == 401) {
        return {
          'success': false,
          'message': 'Your session has expired. Please log in again.',
          'isUnauthorized': true,
        };
      }
      else {
        return {
          'success': false,
          'message': decodedBody['message'] ?? 'Error: ${response.statusCode}',
        };
      }
    } catch (e) {
      if (kDebugMode) print("❌ JSON Parse Error: $e");
      return {
        'success': false,
        'message': 'Received invalid data from the server.',
      };
    }
  }
}
