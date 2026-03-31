import 'dart:convert';
import 'package:codon/utills/api_urls.dart';
import 'package:http/http.dart' as http;
import '../../../utills/base_api_client.dart';
import '../../../utills/prefs_service.dart';

abstract class PearlsService {
  Future<Map<String, dynamic>> getCourse();

  Future<Map<String, dynamic>> getSubjects(String courseId);

  Future<Map<String, dynamic>> getSubSubjects(String subjectId);

  Future<Map<String, dynamic>> getChapters(String subSubjectId);

  Future<Map<String, dynamic>> getChapterFullDetails(String chapterId);

  Future<Map<String, dynamic>> getTopics(String subSubjectId);

  Future<Map<String, dynamic>> getTopicDetails(String topicId);
}

class PearlServiceImpl implements PearlsService {
  @override
  Future<Map<String, dynamic>> getCourse() async {
    try {
      final token = await PrefsService.getAccessToken();
      final response = await http.get(
        Uri.parse(getCoursesUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print("Courses1: ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'success': false, 'message': 'Failed to fetch course'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to fetch course'};
    }
  }

  @override
  Future<Map<String, dynamic>> getSubjects(String courseId) async {
    try {
      final response = await http.get(
        Uri.parse(
          getSubjectUrl,
        ).replace(queryParameters: {'courseId': courseId}),
      );
      print("Subjects: ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'success': false, 'message': 'Failed to fetch subjects'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to fetch subjects'};
    }
  }

  @override
  Future<Map<String, dynamic>> getSubSubjects(String subjectId) async {
    try {
      final response = await http.get(
        Uri.parse(
          getSubSubjectsUrl,
        ).replace(queryParameters: {'subjectId': subjectId}),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'success': false, 'message': 'Failed to fetch sub subjects'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to fetch sub subjects'};
    }
  }

  @override
  Future<Map<String, dynamic>> getChapters(String subSubjectId) async {
    try {
      String? token = BaseApiClient.accessToken;
      final uri = Uri.parse('$getChapterUrl$subSubjectId');
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      print("Chapters of SubSubject: $uri");
      final response = await http.get(uri, headers: headers);
      print("Chapters of SubSubject: ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'success': false, 'message': 'Failed to fetch chapter'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to fetch chapter'};
    }
  }

  @override
  Future<Map<String, dynamic>> getChapterFullDetails(String chapterId) async {
    try {
      final uri = Uri.parse('$getChapterDetailUrl$chapterId');
      print("Chapter Detail: $uri");
      final response = await http.get(uri);
      print("Chapter Detail Response: ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'success': false, 'message': 'Failed to fetch chapter details'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to fetch chapter details'};
    }
  }

  @override
  Future<Map<String, dynamic>> getTopics(String chapterId) async {
    try {
      print('getting topics');
      String? token = BaseApiClient.accessToken;
      final uri = Uri.parse('$getTopicUrl$chapterId');
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      print("Topics of chapter: $uri");
      final response = await http.get(uri, headers: headers);
      print("Topics of chapter: ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'success': false, 'message': 'Failed to fetch topics'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to fetch topics'};
    }
  }

  @override
  Future<Map<String, dynamic>> getTopicDetails(String topicId) async {
    try {
      String? token = BaseApiClient.accessToken;
      final uri = Uri.parse('$getTopicDetailsUrl$topicId');
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      print("Topic detail: $uri");
      final response = await http.get(uri, headers: headers);
      print("Topic detail response: ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'success': false, 'message': 'Failed to fetch topic details'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to fetch topic details'};
    }
  }
}
