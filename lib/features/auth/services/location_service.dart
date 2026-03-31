import 'dart:convert';
import 'package:codon/utills/api_urls.dart';
import 'package:http/http.dart' as http;

abstract class LocationService {
  Future<Map<String, dynamic>> getStates();
  Future<Map<String, dynamic>> getCities({required String stateId});
}

class LocationServiceImpl implements LocationService {
  @override
  Future<Map<String, dynamic>> getStates() async {
    final url = Uri.parse(getStatesUrl);

    final response = await http.get(url);
    print("states response: ${response.body}");
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  @override
  Future<Map<String, dynamic>> getCities({required String stateId}) async {
    final url = Uri.parse("$getCitiesUrl$stateId");

    final response = await http.get(url);
    print("cities response: ${response.body}");
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }
}
