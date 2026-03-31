import 'package:codon/features/videos/domain/models/video_models.dart';
import 'package:get/get.dart';

import '../domain/services/video_services.dart';

class VideosController extends GetxController {
  final VideoService _videoService = Get.find<VideoService>();

  var isSubjectLoading = false.obs;
  var isSubSubjectLoading = false.obs;
  var isTopicLoading = false.obs;
  var isModuleLoading = false.obs;

  final subjects = <VideoSubject>[].obs;
  final subSubjects = <VideoSubSubject>[].obs;
  final topics = <VideoTopic>[].obs;
  final chapters = <VideoTopicChapter>[].obs;
  final allVideosFlatList = <VideoModule>[].obs;
  final topicResponse = Rxn<VideoTopicModuleResponse>();
  final lastSavedProgress = Rxn<VideoProgressModel>();

  final selectedTab = 0.obs;
  static String? courseId;

  @override
  void onInit() {
    super.onInit();
    fetchSubjects(courseId: courseId ?? "696ddc9632f21a5dbfb2a1ff");
  }

  Future<void> _apiHandler({
    required RxBool loader,
    required Future<Map<String, dynamic>> call,
    required Function(Map<String, dynamic> response) onData,
  }) async {
    try {
      loader(true);
      final res = await call;
      if (res['success'] == true) {
        onData(res);
      } else {
        Get.snackbar("Alert", res['message'] ?? "Error");
      }
    } catch (e) {
      Get.snackbar("Error", "Check your connection");
    } finally {
      loader(false);
    }
  }

  void fetchSubjects({required String courseId}) {
    _apiHandler(
      loader: isSubjectLoading,
      call: _videoService.getSubjects(courseId: courseId),
      onData: (res) => subjects.assignAll(
        (res['data'] as List).map((e) => VideoSubject.fromJson(e)).toList(),
      ),
    );
  }

  void fetchSubSubjects({required String subjectId}) {
    subSubjects.clear();
    _apiHandler(
      loader: isSubSubjectLoading,
      call: _videoService.getSubSubjects(subjectId: subjectId),
      onData: (res) => subSubjects.assignAll(
        (res['data'] as List).map((e) => VideoSubSubject.fromJson(e)).toList(),
      ),
    );
  }

  void fetchTopics({required String subSubjectId}) {
    topics.clear();
    _apiHandler(
      loader: isTopicLoading,
      call: _videoService.getTopics(subSubjectId: subSubjectId),
      onData: (res) => topics.assignAll(
        (res['data'] as List).map((e) => VideoTopic.fromJson(e)).toList(),
      ),
    );
  }

  void getVideos({required String topicId}) {
    chapters.clear();
    allVideosFlatList.clear();
    _apiHandler(
      loader: isModuleLoading,
      call: _videoService.getTopicsVideos(topicId: topicId),
      onData: (res) {
        final model = VideoTopicModuleResponse.fromJson(res);
        topicResponse.value = model;
        chapters.assignAll(model.chapters);
        allVideosFlatList.assignAll(
          model.chapters.expand((c) => c.videos).toList(),
        );
      },
    );
  }

  void getChapterVideos({required String chapterId}) {
    allVideosFlatList.clear();
    _apiHandler(
      loader: isModuleLoading,
      call: _videoService.getChapterVideos(chapterId: chapterId),
      onData: (res) {
        if (res['data'] != null && res['data'] is List) {
          final List<dynamic> data = res['data'];
          final videos = data
              .map((json) => VideoModule.fromJson(json))
              .toList();
          allVideosFlatList.assignAll(videos);
        }
      },
    );
  }

  Future<void> syncVideoProgress({
    required String videoId,
    required String topicId,
    required int watchTime,
    required int totalDuration,
  }) async {
    try {
      final result = await _videoService.updateVideoProgress(
        videoId: videoId,
        topicId: topicId,
        watchTime: watchTime,
        totalDuration: totalDuration,
      );
      if (result != null) {
        lastSavedProgress.value = result;

        int index = allVideosFlatList.indexWhere((v) => v.id == videoId);
        if (index != -1) {
          allVideosFlatList[index] = allVideosFlatList[index].copyWith(
            statusTag: result.status,
            watchPercentage: result.percentage,
            lastWatchTime: result.watchTime.toDouble(),
          );
          allVideosFlatList.refresh();
        }
      }
    } catch (e) {
      print("Progress Sync Error: $e");
    }
  }

  List<VideoModule> get filteredModules {
    if (selectedTab.value == 0) return allVideosFlatList;

    String targetStatus = _getStatusFromTab();
    return allVideosFlatList.where((m) => m.statusTag == targetStatus).toList();
  }

  String _getStatusFromTab() {
    if (selectedTab.value == 1) return "watching";
    if (selectedTab.value == 2) return "completed";
    return "unattended";
  }
}
