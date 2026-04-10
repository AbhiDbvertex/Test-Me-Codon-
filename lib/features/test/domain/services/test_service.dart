import 'package:codon/utills/api_urls.dart';
import 'package:get/get.dart';

import '../../../../utills/base_api_client.dart';

abstract class TestService {
  Future<Map<String, dynamic>> getTestCourse({required String courseId});
  Future<Map<String, dynamic>> startTest({required String testId});
  Future<Map<String, dynamic>> fetchQuestion({required String attemptId});
  Future<Map<String, dynamic>> getTestPriviewById({required String testId});

  // --- New APIs ---
  Future<Map<String, dynamic>> submitTest({
    required String attemptId,
    required Map<String, dynamic> body,
  });
  Future<Map<String, dynamic>> getTestDetails({required String testId});
  Future<Map<String, dynamic>> getTestQuestions({required String testId});
  Future<Map<String, dynamic>> updateTestProgress({
    required String attemptId,
    required Map<String, dynamic> body,
  }); // Updated: attemptId for Patch
  Future<Map<String, dynamic>> getExamTests();
  Future<Map<String, dynamic>> startExamTest({required String testId});
  Future<Map<String, dynamic>> submitExamAnswer({
    required String attemptId,
    required String mcqId,
    required int optionId,
  });
  Future<Map<String, dynamic>> submitExamTest({required String attemptId});
}

class TestServiceImpl implements TestService {
  final BaseApiClient _api = Get.find<BaseApiClient>();

  @override
  Future<Map<String, dynamic>> getExamTests() {
    return _api.call(url: getExamTestsUrl, method: 'GET');
  }

  @override
  Future<Map<String, dynamic>> startExamTest({required String testId}) {
    return _api.call(url: "$getExamTestsUrl/$testId/start", method: 'POST');
  }

  @override
  Future<Map<String, dynamic>> getTestCourse({required String courseId}) {
    return _api.call(
      url: getTestUrl,
      method: 'GET',
      queryParams: {'courseId': courseId},
    );
  }

  @override
  Future<Map<String, dynamic>> startTest({required String testId}) {
    return _api.call(url: "$getTestUrl/$testId/start", method: 'POST');
  }

  @override
  Future<Map<String, dynamic>> getTestPriviewById({required String testId}) {
    return _api.call(
      url: "${baseUrl}/api/tests/preview?testId=$testId",
      method: 'GET',
    );
  }

  @override
  Future<Map<String, dynamic>> fetchQuestion({required String attemptId}) {
    return _api.call(url: "$attemptTestUrl$attemptId/question", method: 'GET');
  }

  // 1. Submit Test (POST)
  @override
  Future<Map<String, dynamic>> submitTest({
    required String attemptId,
    required Map<String, dynamic> body,
  }) {
    return _api.call(
      url: "$attemptTestUrl$attemptId/submit",
      method: 'POST',
      body: body,
    );
  }

  // 2. Get Test Info (GET)
  @override
  Future<Map<String, dynamic>> getTestDetails({required String testId}) {
    return _api.call(url: "$getTestUrl/$testId", method: 'GET');
  }

  // 3. Get Questions (GET)
  @override
  Future<Map<String, dynamic>> getTestQuestions({required String testId}) {
    return _api.call(url: "$getTestUrl/$testId/questions", method: 'GET');
  }

  // 4. Update Progress (PATCH)
  @override
  Future<Map<String, dynamic>> updateTestProgress({
    required String attemptId,
    required Map<String, dynamic> body,
  }) {
    return _api.call(
      url: "$attemptTestUrl$attemptId/update",
      method: 'PATCH',
      body: body,
    );
  }

  @override
  Future<Map<String, dynamic>> submitExamAnswer({
    required String attemptId,
    required String mcqId,
    required int optionId,
  }) {
    return _api.call(
      url: "$attemptTestUrl$attemptId/answer",
      method: 'POST',
      body: {"mcqId": mcqId, "optionId": optionId},
    );
  }

  @override
  Future<Map<String, dynamic>> submitExamTest({required String attemptId}) {
    return _api.call(url: "$attemptTestUrl$attemptId/submit", method: 'POST');
  }
}
