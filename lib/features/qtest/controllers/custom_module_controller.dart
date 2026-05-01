// // // // import 'package:codon/features/pearls/models/sub_subject_model.dart';
// // // // import 'package:codon/features/pearls/models/subject_model.dart';
// // // // import 'package:codon/features/pearls/models/topic_model.dart';
// // // // import 'package:codon/features/qtest/models/custom_test_model.dart';
// // // // import 'package:codon/features/qtest/models/tag_model.dart';
// // // // import 'package:codon/features/qtest/screens/custom_test_mcq_screen.dart';
// // // // import 'package:codon/features/pearls/controllers/pearls_controller.dart';
// // // // import 'package:codon/features/qtest/services/qtest_service.dart';
// // // // import 'package:get/get.dart';
// // // //
// // // // import '../../pearls/models/Get_Chapters_Chapter_model.dart';
// // // // import '../../pearls/services/pearl_service.dart';
// // // //
// // // // class CustomModuleController extends GetxController {
// // // //   final QTestService _qTestService = Get.find<QTestService>();
// // // //
// // // //   var isLoading = false.obs;
// // // //   var difficultyLevel = 'all'.obs;
// // // //   var selectedTags = <String>[].obs;
// // // //   var selectedTagId = ''.obs;
// // // //
// // // //   var subjects = <SubjectModel>[].obs;
// // // //   var selectedSubjectId = ''.obs;
// // // //   var tags = <CustomTestTagModel>[].obs;
// // // //
// // // //   var subSubjects = <SubSubjectModel>[].obs;
// // // //   var selectedSubSubjectId = ''.obs;
// // // //
// // // //   var topics = <TopicModel>[].obs;
// // // //   var selectedTopicId = ''.obs;
// // // //
// // // //   var chapters = <ChapterModel>[].obs;
// // // //   var selectedChapterId = ''.obs;
// // // //
// // // //
// // // //
// // // //   var isLoadingSubjects = false.obs;
// // // //   var isLoadingSubSubjects = false.obs;
// // // //   var isLoadingTopics = false.obs;
// // // //   var isLoadingTags = false.obs;
// // // //
// // // //   var mode = 'exam'.obs;
// // // //
// // // //   var selectedTagIds = <String>[].obs;
// // // //
// // // //   @override
// // // //   void onInit() {
// // // //     super.onInit();
// // // //     fetchSubjects();
// // // //     fetchTags();
// // // //   }
// // // //
// // // //   Future<void> fetchSubjects() async {
// // // //     try {
// // // //       isLoadingSubjects.value = true;
// // // //       final fetchedSubjects = await Get.find<PearlsController>().getSubjects();
// // // //       subjects.assignAll([
// // // //         SubjectModel(id: '', name: 'All', order: -1),
// // // //         ...fetchedSubjects,
// // // //       ]);
// // // //       selectedSubjectId.value = ''; // Default to All
// // // //     } catch (e) {
// // // //       print("Error fetching subjects: $e");
// // // //     } finally {
// // // //       isLoadingSubjects.value = false;
// // // //     }
// // // //   }
// // // //   var chaptersList = <GetChaptersChapterModel>[].obs;
// // // //   var errorMessage = ''.obs;
// // // //   Future<void> getChapters(String subSubjectId) async {
// // // //     try {
// // // //       isLoading(true);
// // // //       errorMessage('');
// // // //       final response = await Get.find<PearlsService>().getChapters(
// // // //         subSubjectId,
// // // //       );
// // // //
// // // //       print("Abhi:- getChapter: ${response}");
// // // //
// // // //       if (response['success']) {
// // // //         final List<GetChaptersChapterModel> fetchedChapters =
// // // //         (response['data'] as List)
// // // //             .map((e) => GetChaptersChapterModel.fromJson(e))
// // // //             .toList();
// // // //
// // // //         chaptersList.assignAll(fetchedChapters);
// // // //       } else {
// // // //         errorMessage('Failed to load chapters');
// // // //       }
// // // //     } catch (e) {
// // // //       errorMessage(e.toString());
// // // //     } finally {
// // // //       isLoading(false);
// // // //     }
// // // //   }
// // // //
// // // //   Future<void> fetchSubSubjects(String subjectId) async {
// // // //     try {
// // // //       isLoadingSubSubjects.value = true;
// // // //       subSubjects.clear();
// // // //       selectedSubSubjectId.value = '';
// // // //       topics.clear();
// // // //       selectedTopicId.value = '';
// // // //       chapters.clear();
// // // //       selectedChapterId.value = '';
// // // //
// // // //       final res = await _qTestService.getSubSubjects(subjectId: subjectId);
// // // //       if (res['success'] == true) {
// // // //         subSubjects.assignAll(
// // // //           (res['data'] as List)
// // // //               .map((e) => SubSubjectModel.fromJson(e))
// // // //               .toList(),
// // // //         );
// // // //       }
// // // //     } finally {
// // // //       isLoadingSubSubjects.value = false;
// // // //     }
// // // //   }
// // // //
// // // //
// // // //   Future<void> fetchTopics(String subSubjectId) async {
// // // //     print("Abhi:- fetchTopics subsubjectId : ${subSubjectId}");
// // // //     try {
// // // //       isLoadingTopics.value = true;
// // // //       topics.clear();
// // // //       selectedTopicId.value = '';
// // // //       chapters.clear();
// // // //       selectedChapterId.value = '';
// // // //
// // // //
// // // //
// // // //       final res = await _qTestService.getTopics(subSubjectId);
// // // //       print("Abhi:- fetch topics ${res}");
// // // //       if (res['success'] == true) {
// // // //         topics.assignAll(
// // // //           (res['data'] as List).map((e) => TopicModel.fromJson(e)).toList(),
// // // //         );
// // // //       }
// // // //     } finally {
// // // //       isLoadingTopics.value = false;
// // // //     }
// // // //   }
// // // //
// // // //   Future<void> fetchTags() async {
// // // //     try {
// // // //       isLoadingTags.value = true;
// // // //       final res = await _qTestService.getTags();
// // // //       if (res['success'] == true) {
// // // //         final fetchedTags = (res['data'] as List)
// // // //             .map((e) => CustomTestTagModel.fromJson(e))
// // // //             .toList();
// // // //         tags.assignAll([
// // // //           CustomTestTagModel(id: '', name: 'All'),
// // // //           ...fetchedTags,
// // // //         ]);
// // // //         selectedTagId.value = ''; // Default to All
// // // //       }
// // // //     } finally {
// // // //       isLoadingTags.value = false;
// // // //     }
// // // //   }
// // // //
// // // //   void onSubjectSelected(String? id) {
// // // //     if (id != null && id.isNotEmpty) {
// // // //       selectedSubjectId.value = id;
// // // //       fetchSubSubjects(id);
// // // //     } else {
// // // //       selectedSubjectId.value = '';
// // // //       subSubjects.clear();
// // // //       selectedSubSubjectId.value = '';
// // // //       topics.clear();
// // // //       selectedTopicId.value = '';
// // // //       chapters.clear();
// // // //       selectedChapterId.value = '';
// // // //     }
// // // //   }
// // // //
// // // //   void onSubSubjectSelected(String? id) {
// // // //     if (id != null && id.isNotEmpty) {
// // // //       selectedSubSubjectId.value = id;
// // // //       fetchTopics(id);
// // // //     }
// // // //   }
// // // //
// // // //   void onTopicSelected(String? id) {
// // // //     if (id != null && id.isNotEmpty) {
// // // //       selectedTopicId.value = id;
// // // //       final selectedTopic = topics.firstWhereOrNull((t) => t.id == id);
// // // //       if (selectedTopic != null) {
// // // //         chapters.assignAll(selectedTopic.chapters);
// // // //       } else {
// // // //         chapters.clear();
// // // //       }
// // // //       selectedChapterId.value = '';
// // // //     }
// // // //   }
// // // //
// // // //   void onChapterSelected(String? id) {
// // // //     if (id != null && id.isNotEmpty) {
// // // //       selectedChapterId.value = id;
// // // //     }
// // // //   }
// // // //
// // // //   void onTagSelected(String? id) {
// // // //     if (id != null && id.isNotEmpty) {
// // // //       selectedTagId.value = id;
// // // //     }
// // // //   }
// // // //
// // // //   void setDifficulty(String level) {
// // // //     difficultyLevel.value = level;
// // // //   }
// // // //
// // // //   void setMode(String newMode) {
// // // //     mode.value = newMode;
// // // //   }
// // // //
// // // //   Future<void> createCustomTest() async {
// // // //     try {
// // // //       isLoading.value = true;
// // // //
// // // //       // subjectIds: "all" if nothing selected, else [selectedSubjectId]
// // // //       final dynamic subjectIdsPayload = selectedSubjectId.value.isEmpty
// // // //           ? 'all'
// // // //           : [selectedSubjectId.value];
// // // //
// // // //       // tagIds: "all" if nothing / only 'All' selected, else list of selected ids
// // // //       final realTagIds = selectedTagIds.where((id) => id.isNotEmpty).toList();
// // // //       final dynamic tagIdsPayload = realTagIds.isEmpty ? 'all' : realTagIds;
// // // //
// // // //       final res = await _qTestService.createCustomTest(
// // // //         subjectIds: subjectIdsPayload,
// // // //         tagIds: tagIdsPayload,
// // // //         difficulty: difficultyLevel.value,
// // // //         mode: mode.value,
// // // //         discard: true,
// // // //       );
// // // //       if (res['success'] == true) {
// // // //         Get.back();
// // // //         Get.to(
// // // //           () => CustomTestMcqScreen(customTest: CustomTestModel.fromJson(res)),
// // // //         );
// // // //         Get.snackbar(
// // // //           'Success',
// // // //           'Custom Module created successfully',
// // // //           snackPosition: SnackPosition.TOP,
// // // //         );
// // // //       } else {
// // // //         Get.snackbar('Error', res['message'] ?? 'Failed to create custom test');
// // // //       }
// // // //     } finally {
// // // //       isLoading.value = false;
// // // //     }
// // // //   }
// // // //
// // // //   void cancel() {
// // // //     Get.back();
// // // //   }
// // // //
// // // //   void toggleTag(String id) {
// // // //     if (id == '') {
// // // //       // If 'All' is selected, clear everything else and just keep 'All'
// // // //       selectedTagIds.assignAll(['']);
// // // //       selectedTagId.value = '';
// // // //     } else {
// // // //       // Remove 'All' if specific tag is selected
// // // //       selectedTagIds.remove('');
// // // //
// // // //       if (selectedTagIds.contains(id)) {
// // // //         selectedTagIds.remove(id);
// // // //       } else {
// // // //         selectedTagIds.add(id);
// // // //       }
// // // //
// // // //       // If nothing selected, default to 'All'
// // // //       if (selectedTagIds.isEmpty) {
// // // //         selectedTagIds.assignAll(['']);
// // // //         selectedTagId.value = '';
// // // //       } else {
// // // //         selectedTagId.value = selectedTagIds.first;
// // // //       }
// // // //     }
// // // //     selectedTagIds.refresh();
// // // //   }
// // // //
// // // //   String get selectedTagsDisplay {
// // // //     if (selectedTagIds.isEmpty) return "Select Tags";
// // // //     return tags
// // // //         .where((t) => selectedTagIds.contains(t.id))
// // // //         .map((t) => t.name)
// // // //         .join(", ");
// // // //   }
// // // // }
// // //
// // // import 'package:codon/features/pearls/models/sub_subject_model.dart';
// // // import 'package:codon/features/pearls/models/subject_model.dart';
// // // import 'package:codon/features/pearls/models/topic_model.dart';
// // // import 'package:codon/features/qtest/models/custom_test_model.dart';
// // // import 'package:codon/features/qtest/models/tag_model.dart';
// // // import 'package:codon/features/qtest/screens/custom_test_mcq_screen.dart';
// // // import 'package:codon/features/pearls/controllers/pearls_controller.dart';
// // // import 'package:codon/features/qtest/services/qtest_service.dart';
// // // import 'package:get/get.dart';
// // //
// // // import '../../pearls/models/Get_Chapters_Chapter_model.dart';
// // // import '../../pearls/services/pearl_service.dart';
// // //
// // // class CustomModuleController extends GetxController {
// // //   final QTestService _qTestService = Get.find<QTestService>();
// // //
// // //   var isLoading = false.obs;
// // //   var difficultyLevel = 'all'.obs;
// // //   var selectedTags = <String>[].obs;
// // //   var selectedTagId = ''.obs;
// // //
// // //   var subjects = <SubjectModel>[].obs;
// // //   var selectedSubjectId = ''.obs;
// // //   var tags = <CustomTestTagModel>[].obs;
// // //
// // //   var subSubjects = <SubSubjectModel>[].obs;
// // //   var selectedSubSubjectId = ''.obs;
// // //
// // //   var topics = <TopicModel>[].obs;
// // //   var selectedTopicId = ''.obs;
// // //
// // //   var chapters = <ChapterModel>[].obs;
// // //   var selectedChapterId = ''.obs;
// // //
// // //   var isLoadingChapters = false.obs;  // New loading for chapters
// // //
// // //   var isLoadingSubjects = false.obs;
// // //   var isLoadingSubSubjects = false.obs;
// // //   var isLoadingTopics = false.obs;
// // //   var isLoadingTags = false.obs;
// // //
// // //   var mode = 'exam'.obs;
// // //
// // //   var selectedTagIds = <String>[].obs;
// // //
// // //   // @override
// // //   // void onInit() {
// // //   //   super.onInit();
// // //   //   fetchSubjects();
// // //   //   fetchTags();
// // //   // }
// // //
// // //   @override
// // //   void onInit() {
// // //     super.onInit();
// // //     fetchSubjects();
// // //     fetchTags();
// // //   }
// // //
// // //   Future<void> fetchSubjects() async {
// // //     try {
// // //       isLoadingSubjects.value = true;
// // //       final fetchedSubjects = await Get.find<PearlsController>().getSubjects();
// // //       subjects.assignAll([
// // //         SubjectModel(id: '', name: 'All', order: -1),
// // //         ...fetchedSubjects,
// // //       ]);
// // //       selectedSubjectId.value = ''; // Default to All
// // //     } catch (e) {
// // //       print("Error fetching subjects: $e");
// // //     } finally {
// // //       isLoadingSubjects.value = false;
// // //     }
// // //   }
// // //   var chaptersList = <GetChaptersChapterModel>[].obs;
// // //   var errorMessage = ''.obs;
// // //   Future<void> getChapters(String subSubjectId) async {
// // //     try {
// // //       isLoading(true);
// // //       errorMessage('');
// // //       final response = await Get.find<PearlsService>().getChapters(
// // //         subSubjectId,
// // //       );
// // //
// // //       print("Abhi:- getChapter: ${response}");
// // //
// // //       if (response['success']) {
// // //         final List<GetChaptersChapterModel> fetchedChapters =
// // //         (response['data'] as List)
// // //             .map((e) => GetChaptersChapterModel.fromJson(e))
// // //             .toList();
// // //
// // //         chaptersList.assignAll(fetchedChapters);
// // //       } else {
// // //         errorMessage('Failed to load chapters');
// // //       }
// // //     } catch (e) {
// // //       errorMessage(e.toString());
// // //     } finally {
// // //       isLoading(false);
// // //     }
// // //   }
// // //
// // //   Future<void> fetchSubSubjects(String subjectId) async {
// // //     try {
// // //       isLoadingSubSubjects.value = true;
// // //       subSubjects.clear();
// // //       selectedSubSubjectId.value = '';
// // //       topics.clear();
// // //       selectedTopicId.value = '';
// // //       chapters.clear();
// // //       selectedChapterId.value = '';
// // //
// // //       final res = await _qTestService.getSubSubjects(subjectId: subjectId);
// // //       if (res['success'] == true) {
// // //         subSubjects.assignAll(
// // //           (res['data'] as List)
// // //               .map((e) => SubSubjectModel.fromJson(e))
// // //               .toList(),
// // //         );
// // //       }
// // //     } finally {
// // //       isLoadingSubSubjects.value = false;
// // //     }
// // //   }
// // //
// // //
// // //   Future<void> fetchTopics(String subSubjectId) async {
// // //     print("Abhi:- fetchTopics subsubjectId : ${subSubjectId}");
// // //     try {
// // //       isLoadingTopics.value = true;
// // //       topics.clear();
// // //       selectedTopicId.value = '';
// // //       chapters.clear();
// // //       selectedChapterId.value = '';
// // //
// // //
// // //
// // //       final res = await _qTestService.getTopics(subSubjectId);
// // //       print("Abhi:- fetch topics ${res}");
// // //       if (res['success'] == true) {
// // //         topics.assignAll(
// // //           (res['data'] as List).map((e) => TopicModel.fromJson(e)).toList(),
// // //         );
// // //       }
// // //     } finally {
// // //       isLoadingTopics.value = false;
// // //     }
// // //   }
// // //
// // //   Future<void> fetchTags() async {
// // //     try {
// // //       isLoadingTags.value = true;
// // //       final res = await _qTestService.getTags();
// // //       if (res['success'] == true) {
// // //         final fetchedTags = (res['data'] as List)
// // //             .map((e) => CustomTestTagModel.fromJson(e))
// // //             .toList();
// // //         tags.assignAll([
// // //           CustomTestTagModel(id: '', name: 'All'),
// // //           ...fetchedTags,
// // //         ]);
// // //         selectedTagId.value = ''; // Default to All
// // //       }
// // //     } finally {
// // //       isLoadingTags.value = false;
// // //     }
// // //   }
// // //
// // //   void onSubjectSelected(String? id) {
// // //     if (id != null && id.isNotEmpty) {
// // //       selectedSubjectId.value = id;
// // //       fetchSubSubjects(id);
// // //     } else {
// // //       selectedSubjectId.value = '';
// // //       subSubjects.clear();
// // //       selectedSubSubjectId.value = '';
// // //       topics.clear();
// // //       selectedTopicId.value = '';
// // //       chapters.clear();
// // //       selectedChapterId.value = '';
// // //     }
// // //   }
// // //
// // //   void onSubSubjectSelected(String? id) {
// // //     if (id != null && id.isNotEmpty) {
// // //       selectedSubSubjectId.value = id;
// // //       fetchTopics(id);
// // //     }
// // //   }
// // //
// // //   void onTopicSelected(String? id) {
// // //     if (id != null && id.isNotEmpty) {
// // //       selectedTopicId.value = id;
// // //       final selectedTopic = topics.firstWhereOrNull((t) => t.id == id);
// // //       if (selectedTopic != null) {
// // //         chapters.assignAll(selectedTopic.chapters);
// // //       } else {
// // //         chapters.clear();
// // //       }
// // //       selectedChapterId.value = '';
// // //     }
// // //   }
// // //
// // //   void onChapterSelected(String? id) {
// // //     if (id != null && id.isNotEmpty) {
// // //       selectedChapterId.value = id;
// // //     }
// // //   }
// // //
// // //   void onTagSelected(String? id) {
// // //     if (id != null && id.isNotEmpty) {
// // //       selectedTagId.value = id;
// // //     }
// // //   }
// // //
// // //   void setDifficulty(String level) {
// // //     difficultyLevel.value = level;
// // //   }
// // //
// // //   void setMode(String newMode) {
// // //     mode.value = newMode;
// // //   }
// // //
// // //   Future<void> createCustomTest() async {
// // //     try {
// // //       isLoading.value = true;
// // //
// // //       // subjectIds: "all" if nothing selected, else [selectedSubjectId]
// // //       final dynamic subjectIdsPayload = selectedSubjectId.value.isEmpty
// // //           ? 'all'
// // //           : [selectedSubjectId.value];
// // //
// // //       // tagIds: "all" if nothing / only 'All' selected, else list of selected ids
// // //       final realTagIds = selectedTagIds.where((id) => id.isNotEmpty).toList();
// // //       final dynamic tagIdsPayload = realTagIds.isEmpty ? 'all' : realTagIds;
// // //
// // //       final res = await _qTestService.createCustomTest(
// // //         subjectIds: subjectIdsPayload,
// // //         tagIds: tagIdsPayload,
// // //         difficulty: difficultyLevel.value,
// // //         mode: mode.value,
// // //         discard: true,
// // //       );
// // //       if (res['success'] == true) {
// // //         Get.back();
// // //         Get.to(
// // //               () => CustomTestMcqScreen(customTest: CustomTestModel.fromJson(res)),
// // //         );
// // //         Get.snackbar(
// // //           'Success',
// // //           'Custom Module created successfully',
// // //           snackPosition: SnackPosition.TOP,
// // //         );
// // //       } else {
// // //         Get.snackbar('Error', res['message'] ?? 'Failed to create custom test');
// // //       }
// // //     } finally {
// // //       isLoading.value = false;
// // //     }
// // //   }
// // //
// // //   void cancel() {
// // //     Get.back();
// // //   }
// // //
// // //   void toggleTag(String id) {
// // //     if (id == '') {
// // //       // If 'All' is selected, clear everything else and just keep 'All'
// // //       selectedTagIds.assignAll(['']);
// // //       selectedTagId.value = '';
// // //     } else {
// // //       // Remove 'All' if specific tag is selected
// // //       selectedTagIds.remove('');
// // //
// // //       if (selectedTagIds.contains(id)) {
// // //         selectedTagIds.remove(id);
// // //       } else {
// // //         selectedTagIds.add(id);
// // //       }
// // //
// // //       // If nothing selected, default to 'All'
// // //       if (selectedTagIds.isEmpty) {
// // //         selectedTagIds.assignAll(['']);
// // //         selectedTagId.value = '';
// // //       } else {
// // //         selectedTagId.value = selectedTagIds.first;
// // //       }
// // //     }
// // //     selectedTagIds.refresh();
// // //   }
// // //
// // //   String get selectedTagsDisplay {
// // //     if (selectedTagIds.isEmpty) return "Select Tags";
// // //     return tags
// // //         .where((t) => selectedTagIds.contains(t.id))
// // //         .map((t) => t.name)
// // //         .join(", ");
// // //   }
// // // }

// // import 'dart:convert';

// // import 'package:codon/features/pearls/models/sub_subject_model.dart';
// // import 'package:codon/features/pearls/models/subject_model.dart';
// // import 'package:codon/features/pearls/models/topic_model.dart';
// // import 'package:codon/features/qtest/models/custom_test_model.dart';
// // import 'package:codon/features/qtest/models/tag_model.dart';
// // import 'package:codon/features/qtest/screens/custom_test_mcq_screen.dart';
// // import 'package:codon/features/pearls/controllers/pearls_controller.dart';
// // import 'package:codon/features/qtest/services/qtest_service.dart';
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;

// // import '../../../utills/base_api_client.dart';
// // import '../../pearls/models/Get_Chapters_Chapter_model.dart';
// // import '../../pearls/services/pearl_service.dart';

// // class CustomModuleController extends GetxController {
// //   final QTestService _qTestService = Get.find<QTestService>();

// //   var isLoading = false.obs;
// //   var difficultyLevel = 'all'.obs;
// //   var selectedTags = <String>[].obs;
// //   var selectedTagId = ''.obs;

// //   var subjects = <SubjectModel>[].obs;
// //   var selectedSubjectId = ''.obs;
// //   var tags = <CustomTestTagModel>[].obs;

// //   var subSubjects = <SubSubjectModel>[].obs;
// //   var selectedSubSubjectId = ''.obs;

// //   var chapters =
// //       <GetChaptersChapterModel>[].obs; // Updated to GetChaptersChapterModel
// //   var selectedChapterId = ''.obs;

// //   var topics = <TopicModel>[].obs;
// //   var selectedTopicId = ''.obs;

// //   var isLoadingSubjects = false.obs;
// //   var isLoadingSubSubjects = false.obs;
// //   var isLoadingChapters = false.obs; // New loading for chapters
// //   var isLoadingTopics = false.obs;
// //   var isLoadingTags = false.obs;
// //   //
// //   // var topics = <TopicModel>[].obs;
// //   // var selectedTopicId = ''.obs;
// //   // var isLoadingTopics = false.obs;

// //   var mode = 'exam'.obs;
// //   var selectedTagIds = <String>[].obs;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchSubjects();
// //     fetchTags();
// //   }

// //   Future<void> fetchSubjects() async {
// //     try {
// //       isLoadingSubjects.value = true;
// //       final fetchedSubjects = await Get.find<PearlsController>().getSubjects();
// //       subjects.assignAll([
// //         SubjectModel(id: '', name: 'All', order: -1),
// //         ...fetchedSubjects,
// //       ]);
// //       selectedSubjectId.value = '';
// //     } catch (e) {
// //       print("Error fetching subjects: $e");
// //     } finally {
// //       isLoadingSubjects.value = false;
// //     }
// //   }

// //   Future<void> getChapters(String subSubjectId) async {
// //     // Already in your code, but integrated
// //     try {
// //       isLoadingChapters.value = true; // Use new loading
// //       chapters.clear();
// //       selectedChapterId.value = '';
// //       topics.clear();
// //       selectedTopicId.value = '';

// //       final response = await Get.find<PearlsService>().getChapters(
// //         subSubjectId,
// //       );
// //       print("Fetched chapters for subSubject $subSubjectId: $response");

// //       if (response['success']) {
// //         final List<GetChaptersChapterModel> fetchedChapters =
// //             (response['data'] as List)
// //                 .map((e) => GetChaptersChapterModel.fromJson(e))
// //                 .toList();
// //         chapters.assignAll(fetchedChapters);
// //       } else {
// //         print('Failed to load chapters');
// //       }
// //     } catch (e) {
// //       print("Error fetching chapters: $e");
// //     } finally {
// //       isLoadingChapters.value = false;
// //     }
// //   }

// //   Future<void> fetchSubSubjects(String subjectId) async {
// //     try {
// //       isLoadingSubSubjects.value = true;
// //       subSubjects.clear();
// //       selectedSubSubjectId.value = '';
// //       chapters.clear();
// //       selectedChapterId.value = '';
// //       topics.clear();
// //       selectedTopicId.value = '';

// //       final res = await _qTestService.getSubSubjects(subjectId: subjectId);
// //       print("Fetched subsubjects for subject $subjectId: $res");
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

// //   // Future<void> fetchTopics(String chapterId) async {  // Updated: Now based on chapterId
// //   //   print("Fetching topics for chapterId: $chapterId");
// //   //   try {
// //   //     isLoadingTopics.value = true;
// //   //     topics.clear();
// //   //     selectedTopicId.value = '';
// //   //
// //   //     final res = await _qTestService.getTopics(chapterId);  // Assume new param 'chapterId'
// //   //     print("Fetched topics: $res");
// //   //     if (res['success'] == true) {
// //   //       topics.assignAll(
// //   //         (res['data'] as List).map((e) => TopicModel.fromJson(e)).toList(),
// //   //       );
// //   //     }
// //   //   } finally {
// //   //     isLoadingTopics.value = false;
// //   //   }
// //   // }

// //   // Future<void> fetchTopics(String chapterId) async {
// //   //   print("Fetching topics for chapterId: $chapterId");
// //   //   try {
// //   //     isLoadingTopics.value = true;
// //   //     topics.clear();
// //   //     selectedTopicId.value = '';
// //   //
// //   //     final res = await _qTestService.getTopics(chapterId);  // ← yeh service method implement karna zaroori hai
// //   //
// //   //     if (res['success'] == true) {
// //   //       topics.assignAll(
// //   //         (res['data'] as List).map((e) => TopicModel.fromJson(e)).toList(),
// //   //       );
// //   //     } else {
// //   //       Get.snackbar('Error', 'Failed to load topics');
// //   //     }
// //   //   } catch (e) {
// //   //     print("Error fetching topics: $e");
// //   //     Get.snackbar('Error', 'Something went wrong');
// //   //   } finally {
// //   //     isLoadingTopics.value = false;
// //   //   }
// //   // }

// //   Future<void> fetchTopics(String chapterId) async {
// //     print("Fetching topics for chapterId: $chapterId");
// //     try {
// //       isLoadingTopics.value = true;
// //       topics.clear();
// //       selectedTopicId.value = '';

// //       // ← Yeh line change karo - sahi endpoint daalo
// //       final String url =
// //           'https://api.codonneetug.com/api/users/topics/chapter/$chapterId';
// //       // Ya jo bhi sahi ho: '/api/topics?chapterId=$chapterId' etc.

// //       final api = BaseApiClient(); // tumhara base client

// //       final response = await api.call(url: url, method: 'GET');

// //       print("Topics API Response: $response");

// //       if (response['success'] == true) {
// //         final List<dynamic> data = response['data'] ?? [];
// //         topics.assignAll(data.map((e) => TopicModel.fromJson(e)).toList());
// //         print("Fetched ${topics.length} topics");
// //       } else {
// //         Get.snackbar('Error', response['message'] ?? 'Failed to load topics');
// //       }
// //     } catch (e) {
// //       print("Error fetching topics: $e");
// //       Get.snackbar('Error', 'Something went wrong while loading topics');
// //     } finally {
// //       isLoadingTopics.value = false;
// //     }
// //   }

// //   Future<Map<String, dynamic>> getTopics(String chapterId) async {
// //     try {
// //       final response = await http.get(
// //         Uri.parse('your_api_endpoint/topics?chapterId=$chapterId'),
// //         headers: {'Authorization': 'Bearer your_token'},
// //       );

// //       if (response.statusCode == 200) {
// //         return jsonDecode(response.body);
// //       } else {
// //         return {'success': false, 'message': 'Failed to fetch'};
// //       }
// //     } catch (e) {
// //       return {'success': false, 'message': e.toString()};
// //     }
// //   }

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
// //         selectedTagId.value = '';
// //       }
// //     } finally {
// //       isLoadingTags.value = false;
// //     }
// //   }

// //   void onSubjectSelected(String? id) {
// //     if (id != null && id.isNotEmpty) {
// //       selectedSubjectId.value = id;
// //       fetchSubSubjects(id);
// //     } else {
// //       selectedSubjectId.value = '';
// //       subSubjects.clear();
// //       selectedSubSubjectId.value = '';
// //       chapters.clear();
// //       selectedChapterId.value = '';
// //       topics.clear();
// //       selectedTopicId.value = '';
// //     }
// //   }

// //   void onSubSubjectSelected(String? id) {
// //     if (id != null && id.isNotEmpty) {
// //       selectedSubSubjectId.value = id;
// //       getChapters(id); // Now fetch chapters on subsubject select
// //     } else {
// //       selectedSubSubjectId.value = '';
// //       chapters.clear();
// //       selectedChapterId.value = '';
// //       topics.clear();
// //       selectedTopicId.value = '';
// //     }
// //   }

// //   void onChapterSelected(String? id) {
// //     // Updated: Now fetches topics
// //     if (id != null && id.isNotEmpty) {
// //       selectedChapterId.value = id;
// //       fetchTopics(id); // Fetch topics based on chapter
// //     } else {
// //       selectedChapterId.value = '';
// //       topics.clear();
// //       selectedTopicId.value = '';
// //     }
// //   }

// //   void onTopicSelected(String? id) {
// //     if (id != null && id.isNotEmpty) {
// //       selectedTopicId.value = id;
// //     }
// //   }

// //   void onTagSelected(String? id) {
// //     if (id != null && id.isNotEmpty) {
// //       selectedTagId.value = id;
// //     }
// //   }

// //   void setDifficulty(String level) {
// //     difficultyLevel.value = level;
// //   }

// //   void setMode(String newMode) {
// //     mode.value = newMode;
// //   }

// //   Future<void> createCustomTest() async {
// //     try {
// //       isLoading.value = true;

// //       // Payload updates: Add subSubject, chapter, topic IDs
// //       final dynamic subjectIdsPayload = selectedSubjectId.value.isEmpty
// //           ? 'all'
// //           : [selectedSubjectId.value];
// //       final dynamic subSubjectIdsPayload = selectedSubSubjectId.value.isEmpty
// //           ? 'all'
// //           : [selectedSubSubjectId.value];
// //       final dynamic chapterIdsPayload = selectedChapterId.value.isEmpty
// //           ? 'all'
// //           : [selectedChapterId.value];
// //       final dynamic topicIdsPayload = selectedTopicId.value.isEmpty
// //           ? 'all'
// //           : [selectedTopicId.value];

// //       final realTagIds = selectedTagIds.where((id) => id.isNotEmpty).toList();
// //       final dynamic tagIdsPayload = realTagIds.isEmpty ? 'all' : realTagIds;

// //       print(
// //         "Payload: subjects=$subjectIdsPayload, subsubjects=$subSubjectIdsPayload, chapters=$chapterIdsPayload, topics=$topicIdsPayload, tags=$tagIdsPayload",
// //       );

// //       final res = await _qTestService.createCustomTest(
// //         subjectIds: subjectIdsPayload,
// //         SubsubjectIds: subSubjectIdsPayload, // New
// //         chapterId: chapterIdsPayload, // New
// //         // topicIds: topicIdsPayload,            // New
// //         tagIds: tagIdsPayload,
// //         difficulty: difficultyLevel.value,
// //         mode: mode.value,
// //         discard: true,
// //       );
// //       print("API Response: $res");

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
// //         print("Abhi:- CustomTestMcqScreen.fromJson");
// //       } else {
// //         Get.snackbar('Error', res['message'] ?? 'Failed to create custom test');
// //       }
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }

// //   void cancel() {
// //     Get.back();
// //   }

// //   Future<void> getTopic(chapterId) async {
// //     final api = BaseApiClient();

// //     final response = await api.call(
// //       url:
// //           'https://api.codonneetug.com/api/tests/qtest/69946c182438e61fddf8a542',
// //       method: 'GET',
// //     );

// //     if (response['success'] == true) {
// //       print(response);
// //     } else {
// //       print(response['message']);
// //     }
// //   }

// //   void toggleTag(String id) {
// //     if (id == '') {
// //       selectedTagIds.assignAll(['']);
// //       selectedTagId.value = '';
// //     } else {
// //       selectedTagIds.remove('');
// //       if (selectedTagIds.contains(id)) {
// //         selectedTagIds.remove(id);
// //       } else {
// //         selectedTagIds.add(id);
// //       }
// //       if (selectedTagIds.isEmpty) {
// //         selectedTagIds.assignAll(['']);
// //         selectedTagId.value = '';
// //       } else {
// //         selectedTagId.value = selectedTagIds.first;
// //       }
// //     }
// //     selectedTagIds.refresh();
// //   }

// //   String get selectedTagsDisplay {
// //     if (selectedTagIds.isEmpty) return "Select Tags";
// //     return tags
// //         .where((t) => selectedTagIds.contains(t.id))
// //         .map((t) => t.name)
// //         .join(", ");
// //   }
// // }
// ///////////////////////////////////////////////////
// // import 'package:codon/features/pearls/models/sub_subject_model.dart';
// // import 'package:codon/features/pearls/models/subject_model.dart';
// // import 'package:codon/features/pearls/models/topic_model.dart';
// // import 'package:codon/features/qtest/models/custom_test_model.dart';
// // import 'package:codon/features/qtest/models/tag_model.dart';
// // import 'package:codon/features/qtest/screens/custom_test_mcq_screen.dart';
// // import 'package:codon/features/pearls/controllers/pearls_controller.dart';
// // import 'package:codon/features/qtest/services/qtest_service.dart';
// // import 'package:get/get.dart';

// // import '../../../utills/base_api_client.dart';
// // import '../../pearls/models/Get_Chapters_Chapter_model.dart';
// // import '../../pearls/services/pearl_service.dart';

// // class CustomModuleController extends GetxController {
// //   final QTestService _qTestService = Get.find<QTestService>();

// //   var isLoading = false.obs;
// //   var difficultyLevel = 'all'.obs;
// //   var mode = 'exam'.obs;

// //   // Subject
// //   var subjects = <SubjectModel>[].obs;
// //   var selectedSubjectId = ''.obs;
// //   var isLoadingSubjects = false.obs;

// //   // Sub Subject
// //   var subSubjects = <SubSubjectModel>[].obs;
// //   var selectedSubSubjectId = ''.obs;
// //   var isLoadingSubSubjects = false.obs;

// //   // Chapter — multi-select
// //   var chapters = <GetChaptersChapterModel>[].obs;
// //   var selectedChapterIds = <String>[].obs; // ← RxList
// //   var isLoadingChapters = false.obs;

// //   // Topic — multi-select
// //   var topics = <TopicModel>[].obs;
// //   var selectedTopicIds = <String>[].obs; // ← RxList
// //   var isLoadingTopics = false.obs;

// //   // Tags — multi-select
// //   var tags = <CustomTestTagModel>[].obs;
// //   var selectedTagIds = <String>[].obs;
// //   var isLoadingTags = false.obs;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchSubjects();
// //     fetchTags();
// //   }

// //   // ─── Subjects ───────────────────────────────────────────────────────────────

// //   Future<void> fetchSubjects() async {
// //     try {
// //       isLoadingSubjects.value = true;
// //       final fetched = await Get.find<PearlsController>().getSubjects();
// //       subjects.assignAll(fetched);
// //       selectedSubjectId.value = '';
// //     } catch (e) {
// //       print("Error fetching subjects: $e");
// //     } finally {
// //       isLoadingSubjects.value = false;
// //     }
// //   }

// //   void onSubjectSelected(String? id) {
// //     selectedSubjectId.value = id ?? '';
// //     subSubjects.clear();
// //     selectedSubSubjectId.value = '';
// //     chapters.clear();
// //     selectedChapterIds.clear();
// //     topics.clear();
// //     selectedTopicIds.clear();

// //     if (id != null && id.isNotEmpty) {
// //       fetchSubSubjects(id);
// //     }
// //   }

// //   // ─── Sub Subjects ────────────────────────────────────────────────────────────

// //   Future<void> fetchSubSubjects(String subjectId) async {
// //     try {
// //       isLoadingSubSubjects.value = true;
// //       subSubjects.clear();
// //       selectedSubSubjectId.value = '';
// //       chapters.clear();
// //       selectedChapterIds.clear();
// //       topics.clear();
// //       selectedTopicIds.clear();

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

// //   void onSubSubjectSelected(String? id) {
// //     selectedSubSubjectId.value = id ?? '';
// //     chapters.clear();
// //     selectedChapterIds.clear();
// //     topics.clear();
// //     selectedTopicIds.clear();

// //     if (id != null && id.isNotEmpty) {
// //       fetchChapters(id);
// //     }
// //   }

// //   // ─── Chapters (multi-select) ──────────────────────────────────────────────

// //   Future<void> fetchChapters(String subSubjectId) async {
// //     try {
// //       isLoadingChapters.value = true;
// //       chapters.clear();
// //       selectedChapterIds.clear();
// //       topics.clear();
// //       selectedTopicIds.clear();

// //       final response = await Get.find<PearlsService>().getChapters(
// //         subSubjectId,
// //       );
// //       print("Fetched chapters: $response");

// //       if (response['success'] == true) {
// //         chapters.assignAll(
// //           (response['data'] as List)
// //               .map((e) => GetChaptersChapterModel.fromJson(e))
// //               .toList(),
// //         );
// //       }
// //     } catch (e) {
// //       print("Error fetching chapters: $e");
// //     } finally {
// //       isLoadingChapters.value = false;
// //     }
// //   }

// //   void toggleChapter(String id) {
// //     if (selectedChapterIds.contains(id)) {
// //       selectedChapterIds.remove(id);
// //     } else {
// //       selectedChapterIds.add(id);
// //     }
// //     // Reset topics and re-fetch for all selected chapters
// //     topics.clear();
// //     selectedTopicIds.clear();
// //     if (selectedChapterIds.isNotEmpty) {
// //       fetchTopicsForChapters(selectedChapterIds.toList());
// //     }
// //   }

// //   // ─── Topics (multi-select) ────────────────────────────────────────────────

// //   Future<void> fetchTopicsForChapters(List<String> chapterIds) async {
// //     try {
// //       isLoadingTopics.value = true;
// //       topics.clear();

// //       // Parallel fetch for all selected chapters
// //       final futures = chapterIds.map((id) async {
// //         final api = BaseApiClient();
// //         return await api.call(
// //           url: 'https://api.codonneetug.com/api/users/topics/chapter/$id',
// //           method: 'GET',
// //         );
// //       });

// //       final results = await Future.wait(futures);

// //       final allTopics = <TopicModel>[];
// //       for (final res in results) {
// //         if (res['success'] == true) {
// //           final List<dynamic> data = res['data'] ?? [];
// //           allTopics.addAll(data.map((e) => TopicModel.fromJson(e)));
// //         }
// //       }

// //       // Deduplicate by id
// //       final seen = <String>{};
// //       topics.assignAll(allTopics.where((t) => seen.add(t.id)).toList());

// //       print("Total topics fetched: ${topics.length}");
// //     } catch (e) {
// //       print("Error fetching topics: $e");
// //       Get.snackbar('Error', 'Something went wrong while loading topics');
// //     } finally {
// //       isLoadingTopics.value = false;
// //     }
// //   }

// //   void toggleTopic(String id) {
// //     if (selectedTopicIds.contains(id)) {
// //       selectedTopicIds.remove(id);
// //     } else {
// //       selectedTopicIds.add(id);
// //     }
// //   }

// //   // ─── Tags (multi-select) ──────────────────────────────────────────────────

// //   Future<void> fetchTags() async {
// //     try {
// //       isLoadingTags.value = true;
// //       final res = await _qTestService.getTags();
// //       if (res['success'] == true) {
// //         final fetched = (res['data'] as List)
// //             .map((e) => CustomTestTagModel.fromJson(e))
// //             .toList();
// //         tags.assignAll(fetched);
// //       }
// //     } finally {
// //       isLoadingTags.value = false;
// //     }
// //   }

// //   void toggleTag(String id) {
// //     if (selectedTagIds.contains(id)) {
// //       selectedTagIds.remove(id);
// //     } else {
// //       selectedTagIds.add(id);
// //     }
// //     selectedTagIds.refresh();
// //   }

// //   String get selectedTagsDisplay {
// //     if (selectedTagIds.isEmpty) return "Select Tags";
// //     return tags
// //         .where((t) => selectedTagIds.contains(t.id))
// //         .map((t) => t.name)
// //         .join(", ");
// //   }

// //   // ─── Difficulty & Mode ────────────────────────────────────────────────────

// //   void setDifficulty(String level) => difficultyLevel.value = level;

// //   void setMode(String newMode) => mode.value = newMode;

// //   // ─── Create Test ──────────────────────────────────────────────────────────

// //   Future<void> createCustomTest() async {
// //     try {
// //       isLoading.value = true;

// //       final dynamic subjectIdsPayload = selectedSubjectId.value.isEmpty
// //           ? 'all'
// //           : [selectedSubjectId.value];

// //       final dynamic subSubjectIdsPayload = selectedSubSubjectId.value.isEmpty
// //           ? 'all'
// //           : [selectedSubSubjectId.value];

// //       final dynamic chapterIdsPayload = selectedChapterIds.isEmpty
// //           ? 'all'
// //           : selectedChapterIds.toList();

// //       final dynamic topicIdsPayload = selectedTopicIds.isEmpty
// //           ? 'all'
// //           : selectedTopicIds.toList();

// //       final realTagIds = selectedTagIds.where((id) => id.isNotEmpty).toList();
// //       final dynamic tagIdsPayload = realTagIds.isEmpty ? 'all' : realTagIds;

// //       print(
// //         "Payload → subjects: $subjectIdsPayload | subsubjects: $subSubjectIdsPayload"
// //         " | chapters: $chapterIdsPayload | topics: $topicIdsPayload | tags: $tagIdsPayload",
// //       );

// //       final res = await _qTestService.createCustomTest(
// //         subjectIds: subjectIdsPayload,
// //         SubsubjectIds: subSubjectIdsPayload,
// //         chapterId: chapterIdsPayload,
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

// //   void cancel() => Get.back();
// // }
// ////////////////////////////////////////////
// import 'package:codon/features/pearls/models/sub_subject_model.dart';
// import 'package:codon/features/pearls/models/subject_model.dart';
// import 'package:codon/features/pearls/models/topic_model.dart';
// import 'package:codon/features/qtest/models/custom_test_model.dart';
// import 'package:codon/features/qtest/models/tag_model.dart';
// import 'package:codon/features/qtest/screens/custom_test_mcq_screen.dart';
// import 'package:codon/features/pearls/controllers/pearls_controller.dart';
// import 'package:codon/features/qtest/services/qtest_service.dart';
// import 'package:get/get.dart';

// import '../../../utills/base_api_client.dart';
// import '../../pearls/models/Get_Chapters_Chapter_model.dart';
// import '../../pearls/services/pearl_service.dart';

// class CustomModuleController extends GetxController {
//   final QTestService _qTestService = Get.find<QTestService>();

//   var isLoading = false.obs;
//   var difficultyLevel = 'all'.obs;
//   var mode = 'regular'.obs;

//   // Number of questions
//   var numberOfQuestions = 25.obs;
//   final List<int> questionOptions = [25, 50, 75, 100];

//   // Subject
//   var subjects = <SubjectModel>[].obs;
//   var selectedSubjectId = ''.obs;
//   var isLoadingSubjects = false.obs;

//   // Sub Subject
//   var subSubjects = <SubSubjectModel>[].obs;
//   var selectedSubSubjectId = ''.obs;
//   var isLoadingSubSubjects = false.obs;

//   // Chapter — multi-select
//   var chapters = <GetChaptersChapterModel>[].obs;
//   var selectedChapterIds = <String>[].obs;
//   var isLoadingChapters = false.obs;

//   // Topic — multi-select
//   var topics = <TopicModel>[].obs;
//   var selectedTopicIds = <String>[].obs;
//   var isLoadingTopics = false.obs;

//   // Tags — multi-select
//   var tags = <CustomTestTagModel>[].obs;
//   var selectedTagIds = <String>[].obs;
//   var isLoadingTags = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchSubjects();
//     fetchTags();
//   }

//   // ─── Subjects ─────────────────────────────────────────────────────────────

//   Future<void> fetchSubjects() async {
//     try {
//       isLoadingSubjects.value = true;
//       final fetched = await Get.find<PearlsController>().getSubjects();
//       subjects.assignAll(fetched);
//       selectedSubjectId.value = '';
//     } catch (e) {
//       print("Error fetching subjects: $e");
//     } finally {
//       isLoadingSubjects.value = false;
//     }
//   }

//   void onSubjectSelected(String? id) {
//     selectedSubjectId.value = id ?? '';
//     subSubjects.clear();
//     selectedSubSubjectId.value = '';
//     chapters.clear();
//     selectedChapterIds.clear();
//     topics.clear();
//     selectedTopicIds.clear();

//     if (id != null && id.isNotEmpty) {
//       fetchSubSubjects(id);
//     }
//   }

//   // ─── Sub Subjects ──────────────────────────────────────────────────────────

//   Future<void> fetchSubSubjects(String subjectId) async {
//     try {
//       isLoadingSubSubjects.value = true;
//       subSubjects.clear();
//       selectedSubSubjectId.value = '';
//       chapters.clear();
//       selectedChapterIds.clear();
//       topics.clear();
//       selectedTopicIds.clear();

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

//   void onSubSubjectSelected(String? id) {
//     selectedSubSubjectId.value = id ?? '';
//     chapters.clear();
//     selectedChapterIds.clear();
//     topics.clear();
//     selectedTopicIds.clear();

//     if (id != null && id.isNotEmpty) {
//       fetchChapters(id);
//     }
//   }

//   // ─── Chapters (multi-select) ───────────────────────────────────────────────

//   Future<void> fetchChapters(String subSubjectId) async {
//     try {
//       isLoadingChapters.value = true;
//       chapters.clear();
//       selectedChapterIds.clear();
//       topics.clear();
//       selectedTopicIds.clear();

//       final response = await Get.find<PearlsService>().getChapters(
//         subSubjectId,
//       );

//       if (response['success'] == true) {
//         chapters.assignAll(
//           (response['data'] as List)
//               .map((e) => GetChaptersChapterModel.fromJson(e))
//               .toList(),
//         );
//       }
//     } catch (e) {
//       print("Error fetching chapters: $e");
//     } finally {
//       isLoadingChapters.value = false;
//     }
//   }

//   void toggleChapter(String id) {
//     if (selectedChapterIds.contains(id)) {
//       selectedChapterIds.remove(id);
//     } else {
//       selectedChapterIds.add(id);
//     }
//     topics.clear();
//     selectedTopicIds.clear();
//     if (selectedChapterIds.isNotEmpty) {
//       fetchTopicsForChapters(selectedChapterIds.toList());
//     }
//   }

//   // ─── Topics (multi-select) ─────────────────────────────────────────────────

//   Future<void> fetchTopicsForChapters(List<String> chapterIds) async {
//     try {
//       isLoadingTopics.value = true;
//       topics.clear();

//       final futures = chapterIds.map((id) async {
//         final api = BaseApiClient();
//         return await api.call(
//           url: 'https://api.codonneetug.com/api/users/topics/chapter/$id',
//           method: 'GET',
//         );
//       });

//       final results = await Future.wait(futures);

//       final allTopics = <TopicModel>[];
//       for (final res in results) {
//         if (res['success'] == true) {
//           final List<dynamic> data = res['data'] ?? [];
//           allTopics.addAll(data.map((e) => TopicModel.fromJson(e)));
//         }
//       }

//       final seen = <String>{};
//       topics.assignAll(allTopics.where((t) => seen.add(t.id)).toList());
//     } catch (e) {
//       print("Error fetching topics: $e");
//     } finally {
//       isLoadingTopics.value = false;
//     }
//   }

//   void toggleTopic(String id) {
//     if (selectedTopicIds.contains(id)) {
//       selectedTopicIds.remove(id);
//     } else {
//       selectedTopicIds.add(id);
//     }
//   }

//   // ─── Tags (multi-select) ───────────────────────────────────────────────────

//   Future<void> fetchTags() async {
//     try {
//       isLoadingTags.value = true;
//       final res = await _qTestService.getTags();
//       if (res['success'] == true) {
//         tags.assignAll(
//           (res['data'] as List)
//               .map((e) => CustomTestTagModel.fromJson(e))
//               .toList(),
//         );
//       }
//     } finally {
//       isLoadingTags.value = false;
//     }
//   }

//   void toggleTag(String id) {
//     if (selectedTagIds.contains(id)) {
//       selectedTagIds.remove(id);
//     } else {
//       selectedTagIds.add(id);
//     }
//     selectedTagIds.refresh();
//   }

//   String get selectedTagsDisplay {
//     if (selectedTagIds.isEmpty) return "Select Tags";
//     return tags
//         .where((t) => selectedTagIds.contains(t.id))
//         .map((t) => t.name)
//         .join(", ");
//   }

//   // ─── Difficulty, Mode, Questions ──────────────────────────────────────────

//   void setDifficulty(String level) => difficultyLevel.value = level;

//   void setMode(String newMode) => mode.value = newMode;

//   void setNumberOfQuestions(int count) => numberOfQuestions.value = count;

//   // ─── Create Test ───────────────────────────────────────────────────────────

//   Future<void> createCustomTest() async {
//     try {
//       isLoading.value = true;

//       // "all" if nothing selected, else the selected list
//       final dynamic subjectIdsPayload = selectedSubjectId.value.isEmpty
//           ? ['all']
//           : [selectedSubjectId.value];

//       final dynamic subSubjectIdsPayload = selectedSubSubjectId.value.isEmpty
//           ? ['all']
//           : [selectedSubSubjectId.value];

//       final dynamic chapterIdsPayload = selectedChapterIds.isEmpty
//           ? ['all']
//           : selectedChapterIds.toList();

//       final dynamic topicIdsPayload = selectedTopicIds.isEmpty
//           ? ['all']
//           : selectedTopicIds.toList();

//       final dynamic tagIdsPayload = selectedTagIds.isEmpty
//           ? ['all']
//           : selectedTagIds.toList();

//       print(
//         "Payload → subjects: $subjectIdsPayload"
//         " | subsubjects: $subSubjectIdsPayload"
//         " | chapters: $chapterIdsPayload"
//         " | topics: $topicIdsPayload"
//         " | tags: $tagIdsPayload"
//         " | questions: ${numberOfQuestions.value}",
//       );

//       final res = await _qTestService.createCustomTest(
//         subjectIds: subjectIdsPayload,
//         subSubjectIds: subSubjectIdsPayload,
//         chapterIds: chapterIdsPayload,
//         topicIds: topicIdsPayload,
//         tagIds: tagIdsPayload,
//         difficulty: difficultyLevel.value,
//         mode: mode.value,
//         discard: true,
//         numberOfQuestions: numberOfQuestions.value,
//       );

//       if (res['success'] == true) {
//         Get.back();
//         Get.to(
//           () => CustomTestMcqScreen(customTest: CustomTestModel.fromJson(res)),
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

//   void cancel() => Get.back();
// }

import 'package:codon/features/pearls/models/sub_subject_model.dart';
import 'package:codon/features/pearls/models/subject_model.dart';
import 'package:codon/features/pearls/models/topic_model.dart';
import 'package:codon/features/qtest/models/custom_test_model.dart';
import 'package:codon/features/qtest/models/tag_model.dart';
import 'package:codon/features/qtest/screens/custom_test_mcq_screen.dart';
import 'package:codon/features/pearls/controllers/pearls_controller.dart';
import 'package:codon/features/qtest/services/qtest_service.dart';
import 'package:get/get.dart';

import '../../../utills/base_api_client.dart';
import '../../pearls/models/Get_Chapters_Chapter_model.dart';
import '../../pearls/services/pearl_service.dart';

class CustomModuleController extends GetxController {
  final QTestService _qTestService = Get.find<QTestService>();

  var isLoading = false.obs;
  var difficultyLevel = 'all'.obs;
  var mode = 'regular'.obs;

  // Number of questions
  var numberOfQuestions = 25.obs;
  final List<int> questionOptions = [25, 50, 75, 100];

  // ────── Subject (Multi-select) ──────────
  var subjects = <SubjectModel>[].obs;
  var selectedSubjectIds = <String>[].obs;
  var isLoadingSubjects = false.obs;

  // ────── Sub Subject (Multi-select) ─────────────
  var subSubjects = <SubSubjectModel>[].obs;
  var selectedSubSubjectIds = <String>[].obs;
  var isLoadingSubSubjects = false.obs;

  // ────── Chapter (multi-select) ──────────────────
  var chapters = <GetChaptersChapterModel>[].obs;
  var selectedChapterIds = <String>[].obs;
  var isLoadingChapters = false.obs;

  // ────── Topic (multi-select) ───────────────────
  var topics = <TopicModel>[].obs;
  var selectedTopicIds = <String>[].obs;
  var isLoadingTopics = false.obs;

  // ────── Tags (multi-select) ────────────────────
  var tags = <CustomTestTagModel>[].obs;
  var selectedTagIds = <String>[].obs;
  var isLoadingTags = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubjects();
    fetchTags();
  }

  // ─── Subjects (Multi-select) ──────────────────────────────────────────────

  Future<void> fetchSubjects() async {
    try {
      isLoadingSubjects.value = true;
      final fetched = await Get.find<PearlsController>().getSubjects();
      subjects.assignAll(fetched);
      selectedSubjectIds.value = [];
    } catch (e) {
      print("Error fetching subjects: $e");
    } finally {
      isLoadingSubjects.value = false;
    }
  }

  void toggleSubject(String id) {
    if (selectedSubjectIds.contains(id)) {
      selectedSubjectIds.remove(id);
    } else {
      selectedSubjectIds.add(id);
    }
    selectedSubjectIds.refresh();

    // Reset dependent selections
    subSubjects.clear();
    selectedSubSubjectIds.clear();
    chapters.clear();
    selectedChapterIds.clear();
    topics.clear();
    selectedTopicIds.clear();

    // Fetch subsubjects for selected subjects
    if (selectedSubjectIds.isNotEmpty) {
      fetchSubSubjectsForMultipleSubjects(selectedSubjectIds.toList());
    }
  }

  void selectAllSubjects() {
    // Check if all are selected
    final allSelected = selectedSubjectIds.length == subjects.length;

    if (allSelected) {
      // Deselect all
      selectedSubjectIds.clear();
      subSubjects.clear();
      selectedSubSubjectIds.clear();
      chapters.clear();
      selectedChapterIds.clear();
      topics.clear();
      selectedTopicIds.clear();
    } else {
      // Select all (excluding any empty/invalid IDs)
      final validIds = subjects
          .where((s) => s.id.isNotEmpty)
          .map((s) => s.id)
          .toList();
      selectedSubjectIds.assignAll(validIds);
      if (validIds.isNotEmpty) {
        fetchSubSubjectsForMultipleSubjects(validIds);
      }
    }
    selectedSubjectIds.refresh();
  }

  String get selectedSubjectsDisplay {
    if (selectedSubjectIds.isEmpty) return "Select Subjects";
    if (selectedSubjectIds.length == subjects.length) return "All Subjects";
    return subjects
        .where((s) => selectedSubjectIds.contains(s.id))
        .map((s) => s.name)
        .join(", ");
  }

  // ─── Sub Subjects (Multi-select) ─────────────────────────────────────────

  Future<void> fetchSubSubjectsForMultipleSubjects(
    List<String> subjectIds,
  ) async {
    try {
      isLoadingSubSubjects.value = true;
      subSubjects.clear();
      selectedSubSubjectIds.clear();
      chapters.clear();
      selectedChapterIds.clear();
      topics.clear();
      selectedTopicIds.clear();

      // Fetch for all selected subjects in parallel
      final futures = subjectIds.map((id) async {
        try {
          final res = await _qTestService.getSubSubjects(subjectId: id);
          if (res['success'] == true) {
            return (res['data'] as List)
                .map((e) => SubSubjectModel.fromJson(e))
                .toList();
          }
        } catch (e) {
          print("Error fetching subsubjects for subject $id: $e");
        }
        return <SubSubjectModel>[];
      });

      final results = await Future.wait(futures);

      // Combine all subsubjects and deduplicate by id
      final allSubSubjects = <SubSubjectModel>[];
      for (final list in results) {
        allSubSubjects.addAll(list);
      }

      final seen = <String>{};
      subSubjects.assignAll(
        allSubSubjects.where((s) => seen.add(s.id)).toList(),
      );
    } catch (e) {
      print("Error in fetchSubSubjectsForMultipleSubjects: $e");
    } finally {
      isLoadingSubSubjects.value = false;
    }
  }

  void toggleSubSubject(String id) {
    if (selectedSubSubjectIds.contains(id)) {
      selectedSubSubjectIds.remove(id);
    } else {
      selectedSubSubjectIds.add(id);
    }
    selectedSubSubjectIds.refresh();

    // Reset dependent selections
    chapters.clear();
    selectedChapterIds.clear();
    topics.clear();
    selectedTopicIds.clear();

    // Fetch chapters for selected subsubjects
    if (selectedSubSubjectIds.isNotEmpty) {
      fetchChaptersForMultipleSubSubjects(selectedSubSubjectIds.toList());
    }
  }

  void selectAllSubSubjects() {
    // Check if all are selected
    final allSelected = selectedSubSubjectIds.length == subSubjects.length;

    if (allSelected) {
      // Deselect all
      selectedSubSubjectIds.clear();
      chapters.clear();
      selectedChapterIds.clear();
      topics.clear();
      selectedTopicIds.clear();
    } else {
      // Select all (excluding any empty/invalid IDs)
      final validIds = subSubjects
          .where((s) => s.id.isNotEmpty)
          .map((s) => s.id)
          .toList();
      selectedSubSubjectIds.assignAll(validIds);
      if (validIds.isNotEmpty) {
        fetchChaptersForMultipleSubSubjects(validIds);
      }
    }
    selectedSubSubjectIds.refresh();
  }

  String get selectedSubSubjectsDisplay {
    if (selectedSubSubjectIds.isEmpty) return "Select Sub-Subjects";
    if (selectedSubSubjectIds.length == subSubjects.length) {
      return "All Sub-Subjects";
    }
    return subSubjects
        .where((s) => selectedSubSubjectIds.contains(s.id))
        .map((s) => s.name)
        .join(", ");
  }

  // ─── Chapters (multi-select) ───────────────────────────────────────────────

  Future<void> fetchChaptersForMultipleSubSubjects(
    List<String> subSubjectIds,
  ) async {
    try {
      isLoadingChapters.value = true;
      chapters.clear();
      selectedChapterIds.clear();
      topics.clear();
      selectedTopicIds.clear();

      // Fetch for all selected subsubjects in parallel
      final futures = subSubjectIds.map((id) async {
        try {
          final response = await Get.find<PearlsService>().getChapters(id);
          if (response['success'] == true) {
            return (response['data'] as List)
                .map((e) => GetChaptersChapterModel.fromJson(e))
                .toList();
          }
        } catch (e) {
          print("Error fetching chapters for subsubject $id: $e");
        }
        return <GetChaptersChapterModel>[];
      });

      final results = await Future.wait(futures);

      // Combine all chapters and deduplicate by id
      final allChapters = <GetChaptersChapterModel>[];
      for (final list in results) {
        allChapters.addAll(list);
      }

      final seen = <String>{};
      chapters.assignAll(allChapters.where((c) => seen.add(c.id)).toList());
    } catch (e) {
      print("Error in fetchChaptersForMultipleSubSubjects: $e");
    } finally {
      isLoadingChapters.value = false;
    }
  }

  void toggleChapter(String id) {
    if (selectedChapterIds.contains(id)) {
      selectedChapterIds.remove(id);
    } else {
      selectedChapterIds.add(id);
    }
    topics.clear();
    selectedTopicIds.clear();
    if (selectedChapterIds.isNotEmpty) {
      fetchTopicsForChapters(selectedChapterIds.toList());
    }
  }

  void selectAllChapters() {
    if (selectedChapterIds.length == chapters.length) {
      // Deselect all
      selectedChapterIds.clear();
      topics.clear();
      selectedTopicIds.clear();
    } else {
      // Select all
      selectedChapterIds.assignAll(chapters.map((c) => c.id).toList());
      fetchTopicsForChapters(selectedChapterIds.toList());
    }
    selectedChapterIds.refresh();
  }

  String get selectedChaptersDisplay {
    if (selectedChapterIds.isEmpty) return "Select Chapters";
    if (selectedChapterIds.length == chapters.length) return "All Chapters";
    return chapters
        .where((c) => selectedChapterIds.contains(c.id))
        .map((c) => c.name)
        .join(", ");
  }

  // ─── Topics (multi-select) ────────────────────────────────────────────────

  Future<void> fetchTopicsForChapters(List<String> chapterIds) async {
    try {
      isLoadingTopics.value = true;
      topics.clear();

      final futures = chapterIds.map((id) async {
        final api = BaseApiClient();
        return await api.call(
          url: 'https://api.codonneetug.com/api/users/topics/chapter/$id',
          method: 'GET',
        );
      });

      final results = await Future.wait(futures);

      final allTopics = <TopicModel>[];
      for (final res in results) {
        if (res['success'] == true) {
          final List<dynamic> data = res['data'] ?? [];
          allTopics.addAll(data.map((e) => TopicModel.fromJson(e)));
        }
      }

      final seen = <String>{};
      topics.assignAll(allTopics.where((t) => seen.add(t.id)).toList());
    } catch (e) {
      print("Error fetching topics: $e");
    } finally {
      isLoadingTopics.value = false;
    }
  }

  void toggleTopic(String id) {
    if (selectedTopicIds.contains(id)) {
      selectedTopicIds.remove(id);
    } else {
      selectedTopicIds.add(id);
    }
  }

  void selectAllTopics() {
    if (selectedTopicIds.length == topics.length) {
      // Deselect all
      selectedTopicIds.clear();
    } else {
      // Select all
      selectedTopicIds.assignAll(topics.map((t) => t.id).toList());
    }
    selectedTopicIds.refresh();
  }

  String get selectedTopicsDisplay {
    if (selectedTopicIds.isEmpty) return "Select Topics";
    if (selectedTopicIds.length == topics.length) return "All Topics";
    return topics
        .where((t) => selectedTopicIds.contains(t.id))
        .map((t) => t.name)
        .join(", ");
  }

  // ─── Tags (multi-select) ──────────────────────────────────────────────────

  Future<void> fetchTags() async {
    try {
      isLoadingTags.value = true;
      final res = await _qTestService.getTags();
      if (res['success'] == true) {
        tags.assignAll(
          (res['data'] as List)
              .map((e) => CustomTestTagModel.fromJson(e))
              .toList(),
        );
      }
    } finally {
      isLoadingTags.value = false;
    }
  }

  void toggleTag(String id) {
    if (selectedTagIds.contains(id)) {
      selectedTagIds.remove(id);
    } else {
      selectedTagIds.add(id);
    }
    selectedTagIds.refresh();
  }

  void selectAllTags() {
    if (selectedTagIds.length == tags.length) {
      selectedTagIds.clear();
    } else {
      selectedTagIds.assignAll(tags.map((t) => t.id).toList());
    }
    selectedTagIds.refresh();
  }

  String get selectedTagsDisplay {
    if (selectedTagIds.isEmpty) return "Select Tags";
    if (selectedTagIds.length == tags.length) return "All Tags";
    return tags
        .where((t) => selectedTagIds.contains(t.id))
        .map((t) => t.name)
        .join(", ");
  }

  // ─── Difficulty, Mode, Questions ──────────────────────────────────────────

  void setDifficulty(String level) => difficultyLevel.value = level;

  void setMode(String newMode) => mode.value = newMode;

  void setNumberOfQuestions(int count) => numberOfQuestions.value = count;

  // ─── Create Test ───────────────────────────────────────────────────────────

  Future<void> createCustomTest() async {
    try {
      isLoading.value = true;

      final dynamic subjectIdsPayload = selectedSubjectIds.isEmpty
          ? ['all']
          : selectedSubjectIds.toList();

      final dynamic subSubjectIdsPayload = selectedSubSubjectIds.isEmpty
          ? ['all']
          : selectedSubSubjectIds.toList();

      final dynamic chapterIdsPayload = selectedChapterIds.isEmpty
          ? ['all']
          : selectedChapterIds.toList();

      final dynamic topicIdsPayload = selectedTopicIds.isEmpty
          ? ['all']
          : selectedTopicIds.toList();

      final dynamic tagIdsPayload = selectedTagIds.isEmpty
          ? ['all']
          : selectedTagIds.toList();

      print(
        "Payload → subjects: $subjectIdsPayload"
        " | subsubjects: $subSubjectIdsPayload"
        " | chapters: $chapterIdsPayload"
        " | topics: $topicIdsPayload"
        " | tags: $tagIdsPayload"
        " | questions: ${numberOfQuestions.value}",
      );

      final res = await _qTestService.createCustomTest(
        subjectIds: subjectIdsPayload,
        subSubjectIds: subSubjectIdsPayload,
        chapterIds: chapterIdsPayload,
        topicIds: topicIdsPayload,
        tagIds: tagIdsPayload,
        difficulty: difficultyLevel.value,
        mode: mode.value,
        discard: true,
        numberOfQuestions: numberOfQuestions.value,
      );

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
      } else {
        Get.snackbar('Error', res['message'] ?? 'Failed to create custom test');
      }
    } finally {
      isLoading.value = false;
    }
  }

  void cancel() => Get.back();
}
