import 'package:get/get.dart';

import 'package:codon/features/pearls/models/Get_Chapters_Chapter_model.dart';
import 'package:codon/features/pearls/models/chapter_detail_model.dart';
import 'package:codon/features/pearls/models/get_topic_model.dart';
import 'package:codon/features/pearls/models/topic_details_model.dart';
import 'package:codon/features/pearls/models/sub_subject_model.dart';
import 'package:codon/features/pearls/models/subject_model.dart';
import 'package:codon/features/pearls/models/topic_model.dart';
import 'package:codon/features/pearls/services/pearl_service.dart';

class PearlCategory {
  final String name;
  final int count;

  PearlCategory({required this.name, required this.count});
}

class PearlsController extends GetxController {
  var chaptersList = <GetChaptersChapterModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  RxString courseId = ''.obs;

  Future<void> getCourse() async {
    try {
      final response = await Get.find<PearlsService>().getCourse();
      if (response['success']) {
        print(response['data']);
        courseId.value = response['data']['_id'];
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<SubjectModel>> getSubjects() async {
    try {
      await getCourse();
      final response = await Get.find<PearlsService>().getSubjects(
        courseId.value,
      );
      if (response['success']) {
        print(response['data']);
        final subjects = (response['data'] as List)
            .map((e) => SubjectModel.fromJson(e))
            .toList();
        return subjects;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<SubSubjectModel>> getSubSubjects(String subjectId) async {
    try {
      final response = await Get.find<PearlsService>().getSubSubjects(
        subjectId,
      );
      if (response['success']) {
        print(response['data']);
        return (response['data'] as List)
            .map((e) => SubSubjectModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> getChapters(String subSubjectId) async {
    try {
      isLoading(true);
      errorMessage('');
      final response = await Get.find<PearlsService>().getChapters(
        subSubjectId,
      );

      print("Abhi:- getChapter: ${response}");

      if (response['success']) {
        final List<GetChaptersChapterModel> fetchedChapters =
            (response['data'] as List)
                .map((e) => GetChaptersChapterModel.fromJson(e))
                .toList();

        chaptersList.assignAll(fetchedChapters);
      } else {
        errorMessage('Failed to load chapters');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<List<GetTopicModel>> getTopics({required String chapterId}) async {
    try {
      print("getting tpoics");
      final response = await Get.find<PearlsService>().getTopics(chapterId);
      if (response['success']) {
        print(response['data']);
        return (response['data'] as List)
            .map((e) => GetTopicModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<ChapterDetailModel?> fetchChapterFullDetails(String chapterId) async {
    try {
      final response = await Get.find<PearlsService>().getChapterFullDetails(
        chapterId,
      );
      if (response['success']) {
        return ChapterDetailModel.fromJson(response);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<TopicDetailModel?> fetchTopicDetails(String topicId) async {
    try {
      final response = await Get.find<PearlsService>().getTopicDetails(topicId);
      if (response['success']) {
        return TopicDetailModel.fromJson(response);
      }
    } catch (e) {
      print('Error fetching topic details: $e');
    }
    return null;
  }
}
