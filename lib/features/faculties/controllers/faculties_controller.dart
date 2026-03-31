import 'package:codon/features/faculties/model/faculty_model.dart';
import 'package:codon/features/faculties/servies/faculty_service.dart';
import 'package:get/get.dart';

class FacultiesController extends GetxController {
  Future<List<Faculty>> getFaculties() async {
    try {
      final response = await Get.find<FacultyService>().getFaculties();

      // Check if response is already a List (direct array response)
      if (response is List) {
        return (response as List<dynamic>)
            .map((json) => Faculty.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      // Otherwise check for success/data structure
      if (response is Map && response['success'] == true) {
        final List<dynamic> data = response['data'] ?? [];
        return data
            .map((json) => Faculty.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          response is Map
              ? (response['message'] ?? 'Failed to fetch faculties')
              : 'Failed to fetch faculties',
        );
      }
    } catch (e) {
      print('Error fetching faculties: $e');
      rethrow;
    }
  }
}
