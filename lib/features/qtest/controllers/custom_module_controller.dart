// // import 'package:codon/features/pearls/models/sub_subject_model.dart';
// // import 'package:codon/features/pearls/models/subject_model.dart';
// // import 'package:codon/features/pearls/models/topic_model.dart';
// // import 'package:codon/features/qtest/models/custom_test_model.dart';
// // import 'package:codon/features/qtest/models/tag_model.dart';
// // import 'package:codon/features/qtest/screens/custom_test_mcq_screen.dart';
// // import 'package:codon/features/pearls/controllers/pearls_controller.dart';
// // import 'package:codon/features/qtest/services/qtest_service.dart';
// // import 'package:get/get.dart';
// //
// // import '../../pearls/models/Get_Chapters_Chapter_model.dart';
// // import '../../pearls/services/pearl_service.dart';
// //
// // class CustomModuleController extends GetxController {
// //   final QTestService _qTestService = Get.find<QTestService>();
// //
// //   var isLoading = false.obs;
// //   var difficultyLevel = 'all'.obs;
// //   var selectedTags = <String>[].obs;
// //   var selectedTagId = ''.obs;
// //
// //   var subjects = <SubjectModel>[].obs;
// //   var selectedSubjectId = ''.obs;
// //   var tags = <CustomTestTagModel>[].obs;
// //
// //   var subSubjects = <SubSubjectModel>[].obs;
// //   var selectedSubSubjectId = ''.obs;
// //
// //   var topics = <TopicModel>[].obs;
// //   var selectedTopicId = ''.obs;
// //
// //   var chapters = <ChapterModel>[].obs;
// //   var selectedChapterId = ''.obs;
// //
// //
// //
// //   var isLoadingSubjects = false.obs;
// //   var isLoadingSubSubjects = false.obs;
// //   var isLoadingTopics = false.obs;
// //   var isLoadingTags = false.obs;
// //
// //   var mode = 'exam'.obs;
// //
// //   var selectedTagIds = <String>[].obs;
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchSubjects();
// //     fetchTags();
// //   }
// //
// //   Future<void> fetchSubjects() async {
// //     try {
// //       isLoadingSubjects.value = true;
// //       final fetchedSubjects = await Get.find<PearlsController>().getSubjects();
// //       subjects.assignAll([
// //         SubjectModel(id: '', name: 'All', order: -1),
// //         ...fetchedSubjects,
// //       ]);
// //       selectedSubjectId.value = ''; // Default to All
// //     } catch (e) {
// //       print("Error fetching subjects: $e");
// //     } finally {
// //       isLoadingSubjects.value = false;
// //     }
// //   }
// //   var chaptersList = <GetChaptersChapterModel>[].obs;
// //   var errorMessage = ''.obs;
// //   Future<void> getChapters(String subSubjectId) async {
// //     try {
// //       isLoading(true);
// //       errorMessage('');
// //       final response = await Get.find<PearlsService>().getChapters(
// //         subSubjectId,
// //       );
// //
// //       print("Abhi:- getChapter: ${response}");
// //
// //       if (response['success']) {
// //         final List<GetChaptersChapterModel> fetchedChapters =
// //         (response['data'] as List)
// //             .map((e) => GetChaptersChapterModel.fromJson(e))
// //             .toList();
// //
// //         chaptersList.assignAll(fetchedChapters);
// //       } else {
// //         errorMessage('Failed to load chapters');
// //       }
// //     } catch (e) {
// //       errorMessage(e.toString());
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// //
// //   Future<void> fetchSubSubjects(String subjectId) async {
// //     try {
// //       isLoadingSubSubjects.value = true;
// //       subSubjects.clear();
// //       selectedSubSubjectId.value = '';
// //       topics.clear();
// //       selectedTopicId.value = '';
// //       chapters.clear();
// //       selectedChapterId.value = '';
// //
// //       final res = await _qTestService.getSubSubjects(subjectId: subjectId);
// //       if (res['success'] == true) {
// //         subSubjects.assignAll(
// //           (res['data'] as List)
// //               .map((e) => SubSubjectModel.fromJson(e))
// //               .toList(),
// //         );
// //       }
// //     } finally {
// //       isLoadingSubSubjects.value = false;
// //     }
// //   }
// //
// //
// //   Future<void> fetchTopics(String subSubjectId) async {
// //     print("Abhi:- fetchTopics subsubjectId : ${subSubjectId}");
// //     try {
// //       isLoadingTopics.value = true;
// //       topics.clear();
// //       selectedTopicId.value = '';
// //       chapters.clear();
// //       selectedChapterId.value = '';
// //
// //
// //
// //       final res = await _qTestService.getTopics(subSubjectId);
// //       print("Abhi:- fetch topics ${res}");
// //       if (res['success'] == true) {
// //         topics.assignAll(
// //           (res['data'] as List).map((e) => TopicModel.fromJson(e)).toList(),
// //         );
// //       }
// //     } finally {
// //       isLoadingTopics.value = false;
// //     }
// //   }
// //
// //   Future<void> fetchTags() async {
// //     try {
// //       isLoadingTags.value = true;
// //       final res = await _qTestService.getTags();
// //       if (res['success'] == true) {
// //         final fetchedTags = (res['data'] as List)
// //             .map((e) => CustomTestTagModel.fromJson(e))
// //             .toList();
// //         tags.assignAll([
// //           CustomTestTagModel(id: '', name: 'All'),
// //           ...fetchedTags,
// //         ]);
// //         selectedTagId.value = ''; // Default to All
// //       }
// //     } finally {
// //       isLoadingTags.value = false;
// //     }
// //   }
// //
// //   void onSubjectSelected(String? id) {
// //     if (id != null && id.isNotEmpty) {
// //       selectedSubjectId.value = id;
// //       fetchSubSubjects(id);
// //     } else {
// //       selectedSubjectId.value = '';
// //       subSubjects.clear();
// //       selectedSubSubjectId.value = '';
// //       topics.clear();
// //       selectedTopicId.value = '';
// //       chapters.clear();
// //       selectedChapterId.value = '';
// //     }
// //   }
// //
// //   void onSubSubjectSelected(String? id) {
// //     if (id != null && id.isNotEmpty) {
// //       selectedSubSubjectId.value = id;
// //       fetchTopics(id);
// //     }
// //   }
// //
// //   void onTopicSelected(String? id) {
// //     if (id != null && id.isNotEmpty) {
// //       selectedTopicId.value = id;
// //       final selectedTopic = topics.firstWhereOrNull((t) => t.id == id);
// //       if (selectedTopic != null) {
// //         chapters.assignAll(selectedTopic.chapters);
// //       } else {
// //         chapters.clear();
// //       }
// //       selectedChapterId.value = '';
// //     }
// //   }
// //
// //   void onChapterSelected(String? id) {
// //     if (id != null && id.isNotEmpty) {
// //       selectedChapterId.value = id;
// //     }
// //   }
// //
// //   void onTagSelected(String? id) {
// //     if (id != null && id.isNotEmpty) {
// //       selectedTagId.value = id;
// //     }
// //   }
// //
// //   void setDifficulty(String level) {
// //     difficultyLevel.value = level;
// //   }
// //
// //   void setMode(String newMode) {
// //     mode.value = newMode;
// //   }
// //
// //   Future<void> createCustomTest() async {
// //     try {
// //       isLoading.value = true;
// //
// //       // subjectIds: "all" if nothing selected, else [selectedSubjectId]
// //       final dynamic subjectIdsPayload = selectedSubjectId.value.isEmpty
// //           ? 'all'
// //           : [selectedSubjectId.value];
// //
// //       // tagIds: "all" if nothing / only 'All' selected, else list of selected ids
// //       final realTagIds = selectedTagIds.where((id) => id.isNotEmpty).toList();
// //       final dynamic tagIdsPayload = realTagIds.isEmpty ? 'all' : realTagIds;
// //
// //       final res = await _qTestService.createCustomTest(
// //         subjectIds: subjectIdsPayload,
// //         tagIds: tagIdsPayload,
// //         difficulty: difficultyLevel.value,
// //         mode: mode.value,
// //         discard: true,
// //       );
// //       if (res['success'] == true) {
// //         Get.back();
// //         Get.to(
// //           () => CustomTestMcqScreen(customTest: CustomTestModel.fromJson(res)),
// //         );
// //         Get.snackbar(
// //           'Success',
// //           'Custom Module created successfully',
// //           snackPosition: SnackPosition.TOP,
// //         );
// //       } else {
// //         Get.snackbar('Error', res['message'] ?? 'Failed to create custom test');
// //       }
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }
// //
// //   void cancel() {
// //     Get.back();
// //   }
// //
// //   void toggleTag(String id) {
// //     if (id == '') {
// //       // If 'All' is selected, clear everything else and just keep 'All'
// //       selectedTagIds.assignAll(['']);
// //       selectedTagId.value = '';
// //     } else {
// //       // Remove 'All' if specific tag is selected
// //       selectedTagIds.remove('');
// //
// //       if (selectedTagIds.contains(id)) {
// //         selectedTagIds.remove(id);
// //       } else {
// //         selectedTagIds.add(id);
// //       }
// //
// //       // If nothing selected, default to 'All'
// //       if (selectedTagIds.isEmpty) {
// //         selectedTagIds.assignAll(['']);
// //         selectedTagId.value = '';
// //       } else {
// //         selectedTagId.value = selectedTagIds.first;
// //       }
// //     }
// //     selectedTagIds.refresh();
// //   }
// //
// //   String get selectedTagsDisplay {
// //     if (selectedTagIds.isEmpty) return "Select Tags";
// //     return tags
// //         .where((t) => selectedTagIds.contains(t.id))
// //         .map((t) => t.name)
// //         .join(", ");
// //   }
// // }
//
// import 'package:codon/features/pearls/models/sub_subject_model.dart';
// import 'package:codon/features/pearls/models/subject_model.dart';
// import 'package:codon/features/pearls/models/topic_model.dart';
// import 'package:codon/features/qtest/models/custom_test_model.dart';
// import 'package:codon/features/qtest/models/tag_model.dart';
// import 'package:codon/features/qtest/screens/custom_test_mcq_screen.dart';
// import 'package:codon/features/pearls/controllers/pearls_controller.dart';
// import 'package:codon/features/qtest/services/qtest_service.dart';
// import 'package:get/get.dart';
//
// import '../../pearls/models/Get_Chapters_Chapter_model.dart';
// import '../../pearls/services/pearl_service.dart';
//
// class CustomModuleController extends GetxController {
//   final QTestService _qTestService = Get.find<QTestService>();
//
//   var isLoading = false.obs;
//   var difficultyLevel = 'all'.obs;
//   var selectedTags = <String>[].obs;
//   var selectedTagId = ''.obs;
//
//   var subjects = <SubjectModel>[].obs;
//   var selectedSubjectId = ''.obs;
//   var tags = <CustomTestTagModel>[].obs;
//
//   var subSubjects = <SubSubjectModel>[].obs;
//   var selectedSubSubjectId = ''.obs;
//
//   var topics = <TopicModel>[].obs;
//   var selectedTopicId = ''.obs;
//
//   var chapters = <ChapterModel>[].obs;
//   var selectedChapterId = ''.obs;
//
//   var isLoadingChapters = false.obs;  // New loading for chapters
//
//   var isLoadingSubjects = false.obs;
//   var isLoadingSubSubjects = false.obs;
//   var isLoadingTopics = false.obs;
//   var isLoadingTags = false.obs;
//
//   var mode = 'exam'.obs;
//
//   var selectedTagIds = <String>[].obs;
//
//   // @override
//   // void onInit() {
//   //   super.onInit();
//   //   fetchSubjects();
//   //   fetchTags();
//   // }
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchSubjects();
//     fetchTags();
//   }
//
//   Future<void> fetchSubjects() async {
//     try {
//       isLoadingSubjects.value = true;
//       final fetchedSubjects = await Get.find<PearlsController>().getSubjects();
//       subjects.assignAll([
//         SubjectModel(id: '', name: 'All', order: -1),
//         ...fetchedSubjects,
//       ]);
//       selectedSubjectId.value = ''; // Default to All
//     } catch (e) {
//       print("Error fetching subjects: $e");
//     } finally {
//       isLoadingSubjects.value = false;
//     }
//   }
//   var chaptersList = <GetChaptersChapterModel>[].obs;
//   var errorMessage = ''.obs;
//   Future<void> getChapters(String subSubjectId) async {
//     try {
//       isLoading(true);
//       errorMessage('');
//       final response = await Get.find<PearlsService>().getChapters(
//         subSubjectId,
//       );
//
//       print("Abhi:- getChapter: ${response}");
//
//       if (response['success']) {
//         final List<GetChaptersChapterModel> fetchedChapters =
//         (response['data'] as List)
//             .map((e) => GetChaptersChapterModel.fromJson(e))
//             .toList();
//
//         chaptersList.assignAll(fetchedChapters);
//       } else {
//         errorMessage('Failed to load chapters');
//       }
//     } catch (e) {
//       errorMessage(e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> fetchSubSubjects(String subjectId) async {
//     try {
//       isLoadingSubSubjects.value = true;
//       subSubjects.clear();
//       selectedSubSubjectId.value = '';
//       topics.clear();
//       selectedTopicId.value = '';
//       chapters.clear();
//       selectedChapterId.value = '';
//
//       final res = await _qTestService.getSubSubjects(subjectId: subjectId);
//       if (res['success'] == true) {
//         subSubjects.assignAll(
//           (res['data'] as List)
//               .map((e) => SubSubjectModel.fromJson(e))
//               .toList(),
//         );
//       }
//     } finally {
//       isLoadingSubSubjects.value = false;
//     }
//   }
//
//
//   Future<void> fetchTopics(String subSubjectId) async {
//     print("Abhi:- fetchTopics subsubjectId : ${subSubjectId}");
//     try {
//       isLoadingTopics.value = true;
//       topics.clear();
//       selectedTopicId.value = '';
//       chapters.clear();
//       selectedChapterId.value = '';
//
//
//
//       final res = await _qTestService.getTopics(subSubjectId);
//       print("Abhi:- fetch topics ${res}");
//       if (res['success'] == true) {
//         topics.assignAll(
//           (res['data'] as List).map((e) => TopicModel.fromJson(e)).toList(),
//         );
//       }
//     } finally {
//       isLoadingTopics.value = false;
//     }
//   }
//
//   Future<void> fetchTags() async {
//     try {
//       isLoadingTags.value = true;
//       final res = await _qTestService.getTags();
//       if (res['success'] == true) {
//         final fetchedTags = (res['data'] as List)
//             .map((e) => CustomTestTagModel.fromJson(e))
//             .toList();
//         tags.assignAll([
//           CustomTestTagModel(id: '', name: 'All'),
//           ...fetchedTags,
//         ]);
//         selectedTagId.value = ''; // Default to All
//       }
//     } finally {
//       isLoadingTags.value = false;
//     }
//   }
//
//   void onSubjectSelected(String? id) {
//     if (id != null && id.isNotEmpty) {
//       selectedSubjectId.value = id;
//       fetchSubSubjects(id);
//     } else {
//       selectedSubjectId.value = '';
//       subSubjects.clear();
//       selectedSubSubjectId.value = '';
//       topics.clear();
//       selectedTopicId.value = '';
//       chapters.clear();
//       selectedChapterId.value = '';
//     }
//   }
//
//   void onSubSubjectSelected(String? id) {
//     if (id != null && id.isNotEmpty) {
//       selectedSubSubjectId.value = id;
//       fetchTopics(id);
//     }
//   }
//
//   void onTopicSelected(String? id) {
//     if (id != null && id.isNotEmpty) {
//       selectedTopicId.value = id;
//       final selectedTopic = topics.firstWhereOrNull((t) => t.id == id);
//       if (selectedTopic != null) {
//         chapters.assignAll(selectedTopic.chapters);
//       } else {
//         chapters.clear();
//       }
//       selectedChapterId.value = '';
//     }
//   }
//
//   void onChapterSelected(String? id) {
//     if (id != null && id.isNotEmpty) {
//       selectedChapterId.value = id;
//     }
//   }
//
//   void onTagSelected(String? id) {
//     if (id != null && id.isNotEmpty) {
//       selectedTagId.value = id;
//     }
//   }
//
//   void setDifficulty(String level) {
//     difficultyLevel.value = level;
//   }
//
//   void setMode(String newMode) {
//     mode.value = newMode;
//   }
//
//   Future<void> createCustomTest() async {
//     try {
//       isLoading.value = true;
//
//       // subjectIds: "all" if nothing selected, else [selectedSubjectId]
//       final dynamic subjectIdsPayload = selectedSubjectId.value.isEmpty
//           ? 'all'
//           : [selectedSubjectId.value];
//
//       // tagIds: "all" if nothing / only 'All' selected, else list of selected ids
//       final realTagIds = selectedTagIds.where((id) => id.isNotEmpty).toList();
//       final dynamic tagIdsPayload = realTagIds.isEmpty ? 'all' : realTagIds;
//
//       final res = await _qTestService.createCustomTest(
//         subjectIds: subjectIdsPayload,
//         tagIds: tagIdsPayload,
//         difficulty: difficultyLevel.value,
//         mode: mode.value,
//         discard: true,
//       );
//       if (res['success'] == true) {
//         Get.back();
//         Get.to(
//               () => CustomTestMcqScreen(customTest: CustomTestModel.fromJson(res)),
//         );
//         Get.snackbar(
//           'Success',
//           'Custom Module created successfully',
//           snackPosition: SnackPosition.TOP,
//         );
//       } else {
//         Get.snackbar('Error', res['message'] ?? 'Failed to create custom test');
//       }
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   void cancel() {
//     Get.back();
//   }
//
//   void toggleTag(String id) {
//     if (id == '') {
//       // If 'All' is selected, clear everything else and just keep 'All'
//       selectedTagIds.assignAll(['']);
//       selectedTagId.value = '';
//     } else {
//       // Remove 'All' if specific tag is selected
//       selectedTagIds.remove('');
//
//       if (selectedTagIds.contains(id)) {
//         selectedTagIds.remove(id);
//       } else {
//         selectedTagIds.add(id);
//       }
//
//       // If nothing selected, default to 'All'
//       if (selectedTagIds.isEmpty) {
//         selectedTagIds.assignAll(['']);
//         selectedTagId.value = '';
//       } else {
//         selectedTagId.value = selectedTagIds.first;
//       }
//     }
//     selectedTagIds.refresh();
//   }
//
//   String get selectedTagsDisplay {
//     if (selectedTagIds.isEmpty) return "Select Tags";
//     return tags
//         .where((t) => selectedTagIds.contains(t.id))
//         .map((t) => t.name)
//         .join(", ");
//   }
// }


import 'dart:convert';

import 'package:codon/features/pearls/models/sub_subject_model.dart';
import 'package:codon/features/pearls/models/subject_model.dart';
import 'package:codon/features/pearls/models/topic_model.dart';
import 'package:codon/features/qtest/models/custom_test_model.dart';
import 'package:codon/features/qtest/models/tag_model.dart';
import 'package:codon/features/qtest/screens/custom_test_mcq_screen.dart';
import 'package:codon/features/pearls/controllers/pearls_controller.dart';
import 'package:codon/features/qtest/services/qtest_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utills/base_api_client.dart';
import '../../pearls/models/Get_Chapters_Chapter_model.dart';
import '../../pearls/services/pearl_service.dart';

class CustomModuleController extends GetxController {
  final QTestService _qTestService = Get.find<QTestService>();

  var isLoading = false.obs;
  var difficultyLevel = 'all'.obs;
  var selectedTags = <String>[].obs;
  var selectedTagId = ''.obs;

  var subjects = <SubjectModel>[].obs;
  var selectedSubjectId = ''.obs;
  var tags = <CustomTestTagModel>[].obs;

  var subSubjects = <SubSubjectModel>[].obs;
  var selectedSubSubjectId = ''.obs;

  var chapters = <GetChaptersChapterModel>[].obs;  // Updated to GetChaptersChapterModel
  var selectedChapterId = ''.obs;

  var topics = <TopicModel>[].obs;
  var selectedTopicId = ''.obs;

  var isLoadingSubjects = false.obs;
  var isLoadingSubSubjects = false.obs;
  var isLoadingChapters = false.obs;  // New loading for chapters
  var isLoadingTopics = false.obs;
  var isLoadingTags = false.obs;
  //
  // var topics = <TopicModel>[].obs;
  // var selectedTopicId = ''.obs;
  // var isLoadingTopics = false.obs;

  var mode = 'exam'.obs;
  var selectedTagIds = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubjects();
    fetchTags();
  }

  Future<void> fetchSubjects() async {
    try {
      isLoadingSubjects.value = true;
      final fetchedSubjects = await Get.find<PearlsController>().getSubjects();
      subjects.assignAll([
        SubjectModel(id: '', name: 'All', order: -1),
        ...fetchedSubjects,
      ]);
      selectedSubjectId.value = '';
    } catch (e) {
      print("Error fetching subjects: $e");
    } finally {
      isLoadingSubjects.value = false;
    }
  }

  Future<void> getChapters(String subSubjectId) async {  // Already in your code, but integrated
    try {
      isLoadingChapters.value = true;  // Use new loading
      chapters.clear();
      selectedChapterId.value = '';
      topics.clear();
      selectedTopicId.value = '';

      final response = await Get.find<PearlsService>().getChapters(subSubjectId);
      print("Fetched chapters for subSubject $subSubjectId: $response");

      if (response['success']) {
        final List<GetChaptersChapterModel> fetchedChapters =
        (response['data'] as List).map((e) => GetChaptersChapterModel.fromJson(e)).toList();
        chapters.assignAll(fetchedChapters);
      } else {
        print('Failed to load chapters');
      }
    } catch (e) {
      print("Error fetching chapters: $e");
    } finally {
      isLoadingChapters.value = false;
    }
  }

  Future<void> fetchSubSubjects(String subjectId) async {
    try {
      isLoadingSubSubjects.value = true;
      subSubjects.clear();
      selectedSubSubjectId.value = '';
      chapters.clear();
      selectedChapterId.value = '';
      topics.clear();
      selectedTopicId.value = '';

      final res = await _qTestService.getSubSubjects(subjectId: subjectId);
      print("Fetched subsubjects for subject $subjectId: $res");
      if (res['success'] == true) {
        subSubjects.assignAll(
          (res['data'] as List).map((e) => SubSubjectModel.fromJson(e)).toList(),
        );
      }
    } finally {
      isLoadingSubSubjects.value = false;
    }
  }

  // Future<void> fetchTopics(String chapterId) async {  // Updated: Now based on chapterId
  //   print("Fetching topics for chapterId: $chapterId");
  //   try {
  //     isLoadingTopics.value = true;
  //     topics.clear();
  //     selectedTopicId.value = '';
  //
  //     final res = await _qTestService.getTopics(chapterId);  // Assume new param 'chapterId'
  //     print("Fetched topics: $res");
  //     if (res['success'] == true) {
  //       topics.assignAll(
  //         (res['data'] as List).map((e) => TopicModel.fromJson(e)).toList(),
  //       );
  //     }
  //   } finally {
  //     isLoadingTopics.value = false;
  //   }
  // }

  // Future<void> fetchTopics(String chapterId) async {
  //   print("Fetching topics for chapterId: $chapterId");
  //   try {
  //     isLoadingTopics.value = true;
  //     topics.clear();
  //     selectedTopicId.value = '';
  //
  //     final res = await _qTestService.getTopics(chapterId);  // ← yeh service method implement karna zaroori hai
  //
  //     if (res['success'] == true) {
  //       topics.assignAll(
  //         (res['data'] as List).map((e) => TopicModel.fromJson(e)).toList(),
  //       );
  //     } else {
  //       Get.snackbar('Error', 'Failed to load topics');
  //     }
  //   } catch (e) {
  //     print("Error fetching topics: $e");
  //     Get.snackbar('Error', 'Something went wrong');
  //   } finally {
  //     isLoadingTopics.value = false;
  //   }
  // }

  Future<void> fetchTopics(String chapterId) async {
    print("Fetching topics for chapterId: $chapterId");
    try {
      isLoadingTopics.value = true;
      topics.clear();
      selectedTopicId.value = '';

      // ← Yeh line change karo - sahi endpoint daalo
      final String url = 'https://api.codonneetug.com/api/users/topics/chapter/$chapterId';
      // Ya jo bhi sahi ho: '/api/topics?chapterId=$chapterId' etc.

      final api = BaseApiClient();  // tumhara base client

      final response = await api.call(
        url: url,
        method: 'GET',
      );

      print("Topics API Response: $response");

      if (response['success'] == true) {
        final List<dynamic> data = response['data'] ?? [];
        topics.assignAll(
          data.map((e) => TopicModel.fromJson(e)).toList(),
        );
        print("Fetched ${topics.length} topics");
      } else {
        Get.snackbar('Error', response['message'] ?? 'Failed to load topics');
      }
    } catch (e) {
      print("Error fetching topics: $e");
      Get.snackbar('Error', 'Something went wrong while loading topics');
    } finally {
      isLoadingTopics.value = false;
    }
  }

  Future<Map<String, dynamic>> getTopics(String chapterId) async {
    try {
      final response = await http.get(
        Uri.parse('your_api_endpoint/topics?chapterId=$chapterId'),
        headers: {'Authorization': 'Bearer your_token'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'success': false, 'message': 'Failed to fetch'};
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<void> fetchTags() async {
    try {
      isLoadingTags.value = true;
      final res = await _qTestService.getTags();
      if (res['success'] == true) {
        final fetchedTags = (res['data'] as List)
            .map((e) => CustomTestTagModel.fromJson(e))
            .toList();
        tags.assignAll([
          CustomTestTagModel(id: '', name: 'All'),
          ...fetchedTags,
        ]);
        selectedTagId.value = '';
      }
    } finally {
      isLoadingTags.value = false;
    }
  }

  void onSubjectSelected(String? id) {
    if (id != null && id.isNotEmpty) {
      selectedSubjectId.value = id;
      fetchSubSubjects(id);
    } else {
      selectedSubjectId.value = '';
      subSubjects.clear();
      selectedSubSubjectId.value = '';
      chapters.clear();
      selectedChapterId.value = '';
      topics.clear();
      selectedTopicId.value = '';
    }
  }

  void onSubSubjectSelected(String? id) {
    if (id != null && id.isNotEmpty) {
      selectedSubSubjectId.value = id;
      getChapters(id);  // Now fetch chapters on subsubject select
    } else {
      selectedSubSubjectId.value = '';
      chapters.clear();
      selectedChapterId.value = '';
      topics.clear();
      selectedTopicId.value = '';
    }
  }

  void onChapterSelected(String? id) {  // Updated: Now fetches topics
    if (id != null && id.isNotEmpty) {
      selectedChapterId.value = id;
      fetchTopics(id);  // Fetch topics based on chapter
    } else {
      selectedChapterId.value = '';
      topics.clear();
      selectedTopicId.value = '';
    }
  }

  void onTopicSelected(String? id) {
    if (id != null && id.isNotEmpty) {
      selectedTopicId.value = id;
    }
  }

  void onTagSelected(String? id) {
    if (id != null && id.isNotEmpty) {
      selectedTagId.value = id;
    }
  }

  void setDifficulty(String level) {
    difficultyLevel.value = level;
  }

  void setMode(String newMode) {
    mode.value = newMode;
  }

  Future<void> createCustomTest() async {
    try {
      isLoading.value = true;

      // Payload updates: Add subSubject, chapter, topic IDs
      final dynamic subjectIdsPayload = selectedSubjectId.value.isEmpty ? 'all' : [selectedSubjectId.value];
      final dynamic subSubjectIdsPayload = selectedSubSubjectId.value.isEmpty ? 'all' : [selectedSubSubjectId.value];
      final dynamic chapterIdsPayload = selectedChapterId.value.isEmpty ? 'all' : [selectedChapterId.value];
      final dynamic topicIdsPayload = selectedTopicId.value.isEmpty ? 'all' : [selectedTopicId.value];

      final realTagIds = selectedTagIds.where((id) => id.isNotEmpty).toList();
      final dynamic tagIdsPayload = realTagIds.isEmpty ? 'all' : realTagIds;

      print("Payload: subjects=$subjectIdsPayload, subsubjects=$subSubjectIdsPayload, chapters=$chapterIdsPayload, topics=$topicIdsPayload, tags=$tagIdsPayload");

      final res = await _qTestService.createCustomTest(
        subjectIds: subjectIdsPayload,
        SubsubjectIds: subSubjectIdsPayload,  // New
        chapterId: chapterIdsPayload,        // New
        // topicIds: topicIdsPayload,            // New
        tagIds: tagIdsPayload,
        difficulty: difficultyLevel.value,
        mode: mode.value,
        discard: true,
      );
      print("API Response: $res");

      if (res['success'] == true) {
        Get.back();
        Get.to(
              () => CustomTestMcqScreen(customTest: CustomTestModel.fromJson(res)),
        );
        Get.snackbar(
          'Success',
          'Custom Module created successfully',
          snackPosition: SnackPosition.TOP,
        );
        print("Abhi:- CustomTestMcqScreen.fromJson");
      } else {
        Get.snackbar('Error', res['message'] ?? 'Failed to create custom test');
      }
    } finally {
      isLoading.value = false;
    }
  }

  void cancel() {
    Get.back();
  }

  Future<void> getTopic(chapterId) async {

    final api = BaseApiClient();

    final response = await api.call(
      url: 'https://api.codonneetug.com/api/tests/qtest/69946c182438e61fddf8a542',
      method: 'GET',
    );

    if (response['success'] == true) {
      print(response);
    } else {
      print(response['message']);
    }
  }

  void toggleTag(String id) {
    if (id == '') {
      selectedTagIds.assignAll(['']);
      selectedTagId.value = '';
    } else {
      selectedTagIds.remove('');
      if (selectedTagIds.contains(id)) {
        selectedTagIds.remove(id);
      } else {
        selectedTagIds.add(id);
      }
      if (selectedTagIds.isEmpty) {
        selectedTagIds.assignAll(['']);
        selectedTagId.value = '';
      } else {
        selectedTagId.value = selectedTagIds.first;
      }
    }
    selectedTagIds.refresh();
  }

  String get selectedTagsDisplay {
    if (selectedTagIds.isEmpty) return "Select Tags";
    return tags
        .where((t) => selectedTagIds.contains(t.id))
        .map((t) => t.name)
        .join(", ");
  }
}