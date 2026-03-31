import 'package:codon/features/videos/domain/models/video_models.dart';
import 'package:codon/utills/api_urls.dart';
import 'package:get/get.dart';

import '../../../../utills/base_api_client.dart';

abstract class VideoService {
  Future<Map<String, dynamic>> getSubjects({required String courseId});

  Future<Map<String, dynamic>> getSubSubjects({required String subjectId});

  Future<Map<String, dynamic>> getTopics({required String subSubjectId});

  Future<Map<String, dynamic>> getTopicsVideos({required String topicId});

  Future<Map<String, dynamic>> getChapterVideos({required String chapterId});

  Future<VideoProgressModel?> updateVideoProgress({
    required String videoId,
    required String topicId,
    required int watchTime,
    required int totalDuration,
  });
}

class VideoServiceImpl implements VideoService {
  final BaseApiClient _api = Get.find<BaseApiClient>();

  @override
  Future<Map<String, dynamic>> getSubjects({required String courseId}) {
    return _api.call(
      url: getSubjectUrl,
      method: 'GET',
      queryParams: {'courseId': courseId},
    );
  }

  @override
  Future<Map<String, dynamic>> getSubSubjects({required String subjectId}) {
    return _api.call(
      url: getSubSubjectUrl,
      method: 'GET',
      queryParams: {'subjectId': subjectId},
    );
  }

  @override
  Future<Map<String, dynamic>> getTopics({required String subSubjectId}) {
    return _api.call(url: "$getTopicUrl/$subSubjectId", method: 'GET');
  }

  @override
  Future<Map<String, dynamic>> getTopicsVideos({required String topicId}) {
    return _api.call(url: "$getTopicVideosUrl/$topicId", method: 'GET');
  }

  @override
  Future<Map<String, dynamic>> getChapterVideos({required String chapterId}) {
    return _api.call(
      url: "$getChapterVideosUrl/$chapterId/video",
      method: 'GET',
    );
  }

  @override
  Future<VideoProgressModel?> updateVideoProgress({
    required String videoId,
    required String topicId,
    required int watchTime,
    required int totalDuration,
  }) async {
    final response = await _api.call(
      url: updateProgressUrl,
      method: 'POST',
      body: VideoProgressModel.toRequestJson(
        videoId: videoId,
        topicId: topicId,
        watchTime: watchTime,
        totalDuration: totalDuration,
      ),
    );
    if (response['success'] == true && response['data'] != null) {
      return VideoProgressModel.fromJson(response['data']);
    }
    return null;
  }
}
