import 'package:codon/utills/api_urls.dart';
import 'package:codon/utills/base_api_client.dart';
import 'package:get/get.dart';

abstract class QTestService {
  Future<Map<String, dynamic>> getSubjects({required String courseId});
  Future<Map<String, dynamic>> getSubSubjects({required String subjectId});
  Future<Map<String, dynamic>> getTopics(String subSubjectId);
  Future<Map<String, dynamic>> getChaptersByTopic(String topicId);
  Future<Map<String, dynamic>> getQTest(String qTestId);
  Future<Map<String, dynamic>> createCustomTest({
    required dynamic subjectIds,
    required dynamic SubsubjectIds,
    required dynamic chapterId,
    required dynamic tagIds,
    required String difficulty,
    required String mode,
    required bool discard,
    // required id
  });
  Future<Map<String, dynamic>> getTags();
  Future<Map<String, dynamic>> submitQTest({
    required String qtestId,
    required String chapterId,
    required List<Map<String, dynamic>> answers,
  });
  Future<Map<String, dynamic>> getQTests(String chapterId);
  Future<Map<String, dynamic>> getCustomTestHistory();
  Future<Map<String, dynamic>> getCustomTestDetails(String id);
  Future<Map<String, dynamic>> saveCustomAnswer({
    required String attemptId,
    required String mcqId,
    required int selectedIndex,
  });
  Future<Map<String, dynamic>> submitCustomTest({required String attemptId});
}

class QTestServiceImpl implements QTestService {
  final BaseApiClient _api = Get.find<BaseApiClient>();

  @override
  Future<Map<String, dynamic>> getSubjects({required String courseId}) async {
    return _api.call(
      url: getSubjectUrl,
      method: 'GET',
      queryParams: {'courseId': courseId},
    );
  }

  @override
  Future<Map<String, dynamic>> getSubSubjects({
    required String subjectId,
  }) async {
    return _api.call(
      url: getSubSubjectUrl,
      method: 'GET',
      queryParams: {'subjectId': subjectId},
    );
  }

  @override
  Future<Map<String, dynamic>> getTopics(String subSubjectId) async {
    return _api.call(url: '$getChapterUrl$subSubjectId', method: 'GET');
  }

  @override
  Future<Map<String, dynamic>> getChaptersByTopic(String topicId) async {
    return _api.call(url: '$getChapterByTopicUrl/$topicId', method: 'GET');
  }

  @override
  Future<Map<String, dynamic>> getQTest(String qTestId) async {
    return _api.call(url: '$getQTestsUrl/$qTestId/mcqs', method: 'GET');
  }

  @override
  Future<Map<String, dynamic>> createCustomTest({
    required dynamic subjectIds,
    required dynamic SubsubjectIds,
    required dynamic chapterId,
    required dynamic tagIds,
    required String difficulty,
    required String mode,
    required bool discard,
  }) async {
    return _api.call(
      url: generateCustomTestUrl,
      method: 'POST',
      body: {
        "subjectIds": subjectIds,
        "subSubjectIds": SubsubjectIds,
        "chapterIds": chapterId,
        "tagIds": tagIds,
        "difficulty": difficulty,
        "mode": mode,
        "discard": discard,
      },
    );
  }

  @override
  Future<Map<String, dynamic>> getTags() async {
    return _api.call(url: getAllTagsUrl, method: 'GET');
  }

  @override
  Future<Map<String, dynamic>> submitQTest({
    required String qtestId,
    required String chapterId,
    required List<Map<String, dynamic>> answers,
  }) async {
    return _api.call(
      url: submitQTestUrl,
      method: 'POST',
      body: {"qtestId": qtestId, "chapterId": chapterId, "answers": answers},
    );
  }

  @override
  Future<Map<String, dynamic>> getQTests(String chapterId) async {
    return _api.call(url: '$getQTestsUrl/$chapterId', method: 'GET');
  }

  @override
  Future<Map<String, dynamic>> getCustomTestHistory() async {
    return _api.call(url: customTestHistoryUrl, method: 'GET');
  }

  @override
  Future<Map<String, dynamic>> getCustomTestDetails(String id) async {
    return _api.call(url: '$getCustomTestDetailsUrl/$id', method: 'GET');
  }

  @override
  Future<Map<String, dynamic>> saveCustomAnswer({
    required String attemptId,
    required String mcqId,
    required int selectedIndex,
  }) async {
    return _api.call(
      url: saveCustomAnswerUrl,
      method: 'POST',
      body: {
        'attemptId': attemptId,
        'mcqId': mcqId,
        'selectedIndex': selectedIndex,
      },
    );
  }

  @override
  Future<Map<String, dynamic>> submitCustomTest({
    required String attemptId,
  }) async {
    return _api.call(
      url: submitCustomTestUrl,
      method: 'POST',
      body: {'attemptId': attemptId},
    );
  }
}
