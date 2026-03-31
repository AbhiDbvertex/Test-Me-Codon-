import 'dart:convert';
import 'package:codon/utills/api_urls.dart';
import 'package:codon/utills/base_api_client.dart';
import 'package:http/http.dart' as http;

abstract class FacultyService {
  Future<dynamic> getFaculties();
}

class FacultyServiceImpl implements FacultyService {
  @override
  Future<dynamic> getFaculties() async {
    try {
      final response = await http.get(
        Uri.parse(getFacultiesUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (BaseApiClient.accessToken != null &&
              BaseApiClient.accessToken!.isNotEmpty)
            'Authorization': 'Bearer ${BaseApiClient.accessToken}',
        },
      );
      print("faculty list  ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch faculties: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching faculties: $e');
    }
  }
}
