// import 'dart:async';
// import 'package:codon/features/pearls/models/topic_model.dart';
// import 'package:codon/features/qtest/models/chapter_model.dart';
// import 'package:codon/features/qtest/models/chapter_test_model.dart';
// import 'package:codon/features/qtest/models/qtest_models.dart';
// import 'package:codon/features/qtest/screens/quiz_result_screen.dart';
// import 'package:codon/features/qtest/services/qtest_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class QTestController extends GetxController {
//   String currentQTestId = '';
//
//   Future<List<TopicModel>> getTopics({required String subSubjectId}) async {
//     try {
//       final response = await Get.find<QTestService>().getTopics(subSubjectId);
//       if (response['success']) {
//         // print(response['data']);
//         return (response['data'] as List)
//             .map((e) => TopicModel.fromJson(e))
//             .toList();
//       } else {
//         return [];
//       }
//     } catch (e) {
//       print(e);
//       return [];
//     }
//   }
//
//   final questions = <McqModel>[].obs;
//   final isLoading = false.obs;
//
//   // Quiz State
//   final currentQuestionIndex = 0.obs;
//   final selectedAnswerIndex = (-1).obs;
//   final showPearl = false.obs;
//   final pageController = PageController();
//   final userAnswers = <String, int>{}.obs; // stores questionId -> selectedIndex
//
//   void resetQuiz() {
//     currentQuestionIndex.value = 0;
//     selectedAnswerIndex.value = -1;
//     showPearl.value = false;
//     userAnswers.clear();
//     if (pageController.hasClients) {
//       pageController.jumpToPage(0);
//     }
//     _startTimer();
//   }
//
//   Timer? _questionTimer;
//   final remainingSeconds = 60.obs;
//
//   void _startTimer() {
//     _questionTimer?.cancel();
//     remainingSeconds.value = 60;
//     _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (remainingSeconds.value > 0) {
//         remainingSeconds.value--;
//       } else {
//         _questionTimer?.cancel();
//         nextQuestion();
//       }
//     });
//   }
//
//   Future<void> fetchQTest(String qTestId) async {
//     currentQTestId = qTestId;
//     isLoading.value = true;
//     try {
//       final response = await Get.find<QTestService>().getQTest(qTestId);
//       if (response['success']) {
//         final data = response['data'] as List;
//         questions.assignAll(data.map((e) => McqModel.fromJson(e)).toList());
//         resetQuiz();
//       } else {
//         Get.snackbar('Error', response['message'] ?? 'Failed to load MCQs');
//       }
//     } catch (e) {
//       print(e);
//       Get.snackbar('Error', 'An error occurred while fetching MCQs');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   @override
//   void onClose() {
//     _questionTimer?.cancel();
//     pageController.dispose();
//     super.onClose();
//   }
//
//   void selectAnswer(int index) {
//     final currentQuestion = questions[currentQuestionIndex.value];
//     if (userAnswers.containsKey(currentQuestion.id)) return;
//
//     selectedAnswerIndex.value = index;
//     userAnswers[currentQuestion.id] = index;
//   }
//
//   void togglePearl() {
//     showPearl.value = !showPearl.value;
//   }
//
//   void onPageChanged(int index) {
//     currentQuestionIndex.value = index;
//     final currentQuestion = questions[index];
//     if (userAnswers.containsKey(currentQuestion.id)) {
//       selectedAnswerIndex.value = userAnswers[currentQuestion.id]!;
//     } else {
//       selectedAnswerIndex.value = -1;
//     }
//     showPearl.value = false;
//     _startTimer();
//   }
//
//   void nextQuestion() {
//     if (currentQuestionIndex.value < questions.length - 1) {
//       if (pageController.hasClients) {
//         pageController.nextPage(
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//         );
//       }
//     } else {
//       submitQuiz();
//     }
//   }
//
//   void previousQuestion() {
//     if (currentQuestionIndex.value > 0) {
//       if (pageController.hasClients) {
//         pageController.previousPage(
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//         );
//       }
//     }
//   }
//
//   Future<List<QTestChapterModel>> getChaptersByTopic({
//     required String topicId,
//   }) async {
//     try {
//       final response = await Get.find<QTestService>().getChaptersByTopic(
//         topicId,
//       );
//       if (response['success']) {
//         // print(response['data']);
//         return (response['data'] as List)
//             .map((e) => QTestChapterModel.fromJson(e))
//             .toList();
//       } else {
//         return [];
//       }
//     } catch (e) {
//       print(e);
//       return [];
//     }
//   }
//
//   Future<List<ChapterTestModel>> getQTests({required String chapterId}) async {
//     try {
//       final response = await Get.find<QTestService>().getQTests(chapterId);
//       if (response['success']) {
//         return (response['data'] as List)
//             .map((e) => ChapterTestModel.fromJson(e))
//             .toList();
//       } else {
//         return [];
//       }
//     } catch (e) {
//       print(e);
//       return [];
//     }
//   }
//
//   Future<void> submitQuiz() async {
//     _questionTimer?.cancel();
//     Get.dialog(
//       const Center(child: CircularProgressIndicator()),
//       barrierDismissible: false,
//     );
//
//     final List<Map<String, dynamic>> answers = questions.map((q) {
//       return {"mcqId": q.id, "selectedIndex": userAnswers[q.id]};
//     }).toList();
//
//     try {
//       // Assuming all questions belong to the same chapter, we can take chapterId from the first question
//       // or if it's not available, we need to handle it.
//       String chapterId = '';
//       if (questions.isNotEmpty) {
//         chapterId = questions.first.chapterId;
//       }
//
//       final response = await Get.find<QTestService>().submitQTest(
//         qtestId: currentQTestId,
//         chapterId: chapterId,
//         answers: answers,
//       );
//
//       Get.back(); // Close loading dialog
//
//       if (response['success'] == true) {
//         final result = response['result'];
//         Get.off(
//           () => QuizResultScreen(
//             targetType: "q-test",
//             totalMcqs: result['totalQuestions'] ?? 0,
//             correct: result['correct'] ?? 0,
//             wrong: result['incorrect'] ?? 0,
//             notAttempted: result['notAttempted'] ?? 0,
//             chapterId: currentQTestId,
//             scorePercentage: result['scorePercentage']?.toString(),
//             questions: questions,
//             userAnswers: userAnswers,
//           ),
//         );
//       } else {
//         Get.snackbar("Error", response['message'] ?? "Failed to submit quiz");
//       }
//     } catch (e) {
//       Get.back(); // Close loading dialog
//       Get.snackbar("Error", "An unexpected error occurred");
//       print("Quiz Submission Error: $e");
//     }
//   }
// }

import 'dart:async';
import 'package:codon/features/pearls/models/topic_model.dart';
import 'package:codon/features/qtest/models/chapter_model.dart';
import 'package:codon/features/qtest/models/chapter_test_model.dart';
import 'package:codon/features/qtest/models/qtest_models.dart';
import 'package:codon/features/qtest/screens/quiz_result_screen.dart';
import 'package:codon/features/qtest/services/qtest_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QTestController extends GetxController {
  String currentQTestId = '';

  Future<List<TopicModel>> getTopics({required String subSubjectId}) async {
    try {
      final response = await Get.find<QTestService>().getTopics(subSubjectId);
      if (response['success']) {
        // print(response['data']);
        return (response['data'] as List)
            .map((e) => TopicModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  final questions = <McqModel>[].obs;
  final isLoading = false.obs;

  // Quiz State
  final currentQuestionIndex = 0.obs;
  final selectedAnswerIndex = (-1).obs;
  final showPearl = false.obs;
  final pageController = PageController();
  final userAnswers = <String, int>{}.obs; // stores questionId -> selectedIndex

  void resetQuiz() {
    currentQuestionIndex.value = 0;
    selectedAnswerIndex.value = -1;
    showPearl.value = false;
    userAnswers.clear();
    if (pageController.hasClients) {
      pageController.jumpToPage(0);
    }
    _startTimer();
  }

  Timer? _questionTimer;
  final remainingSeconds = 60.obs;

  void _startTimer() {
    _questionTimer?.cancel();
    remainingSeconds.value = 60;
    _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        _questionTimer?.cancel();
        nextQuestion();
      }
    });
  }

  Future<void> fetchQTest(String qTestId) async {
    currentQTestId = qTestId;
    isLoading.value = true;
    try {
      final response = await Get.find<QTestService>().getQTest(qTestId);
      if (response['success']) {
        final data = response['data'] as List;
        questions.assignAll(data.map((e) => McqModel.fromJson(e)).toList());
        resetQuiz();
      } else {
        Get.snackbar('Error', response['message'] ?? 'Failed to load MCQs');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred while fetching MCQs');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _questionTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }

  void selectAnswer(int index) {
    final currentQuestion = questions[currentQuestionIndex.value];
    if (userAnswers.containsKey(currentQuestion.id)) return;

    selectedAnswerIndex.value = index;
    userAnswers[currentQuestion.id] = index;
  }

  void togglePearl() {
    showPearl.value = !showPearl.value;
  }

  void onPageChanged(int index) {
    currentQuestionIndex.value = index;
    final currentQuestion = questions[index];
    if (userAnswers.containsKey(currentQuestion.id)) {
      selectedAnswerIndex.value = userAnswers[currentQuestion.id]!;
    } else {
      selectedAnswerIndex.value = -1;
    }
    showPearl.value = false;
    _startTimer();
  }

  void nextQuestion({bool isFromCodonPass = false}) {
    if (currentQuestionIndex.value < questions.length - 1) {
      if (pageController.hasClients) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      if (isFromCodonPass) {
        submitQuiz(isFromCodonPass: true);
      } else {
        submitQuiz();
      }
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      if (pageController.hasClients) {
        pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  Future<List<QTestChapterModel>> getChaptersByTopic({
    required String topicId,
  }) async {
    try {
      final response = await Get.find<QTestService>().getChaptersByTopic(
        topicId,
      );
      if (response['success']) {
        // print(response['data']);
        return (response['data'] as List)
            .map((e) => QTestChapterModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<ChapterTestModel>> getQTests({required String chapterId}) async {
    try {
      final response = await Get.find<QTestService>().getQTests(chapterId);
      if (response['success']) {
        return (response['data'] as List)
            .map((e) => ChapterTestModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> submitQuiz({bool isFromCodonPass = false}) async {
    _questionTimer?.cancel();
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    final List<Map<String, dynamic>> answers = questions.map((q) {
      return {"mcqId": q.id, "selectedIndex": userAnswers[q.id] ?? -1};
    }).toList();

    try {
      String chapterId = '';
      if (questions.isNotEmpty) {
        chapterId = questions.first.chapterId;
      }

      // ── Codon (topic-test) path ──────────────────────────────────────────
      if (isFromCodonPass) {
        final response = await Get.find<QTestService>().submitCodonTest(
          qtestId: currentQTestId,
          chapterId: chapterId,
          answers: answers,
        );

        Get.back(); // Close loading dialog

        if (response['success'] == true) {
          final result = response['data'];
          Get.off(
            () => QuizResultScreen(
              targetType: "q-test",
              totalMcqs: result['totalQuestions'] ?? 0,
              correct: result['correct'] ?? 0,
              wrong: result['incorrect'] ?? 0,
              notAttempted: result['notAttempted'] ?? 0,
              chapterId: currentQTestId,
              scorePercentage: result['scorePercentage']?.toString(),
              questions: questions,
              userAnswers: userAnswers,
            ),
          );
        } else {
          Get.snackbar(
            "Error",
            response['message'] ?? "Failed to submit codon test",
          );
        }
        return; // stop here – do NOT call submitQTest
      }

      // ── Regular Q-Test path ───────────────────────────────────────────────
      final response = await Get.find<QTestService>().submitQTest(
        qtestId: currentQTestId,
        chapterId: chapterId,
        answers: answers,
      );

      Get.back(); // Close loading dialog

      if (response['success'] == true) {
        final result = response['result'];
        Get.off(
          () => QuizResultScreen(
            targetType: "q-test",
            totalMcqs: result['totalQuestions'] ?? 0,
            correct: result['correct'] ?? 0,
            wrong: result['incorrect'] ?? 0,
            notAttempted: result['notAttempted'] ?? 0,
            chapterId: currentQTestId,
            scorePercentage: result['scorePercentage']?.toString(),
            questions: questions,
            userAnswers: userAnswers,
          ),
        );
      } else {
        Get.snackbar("Error", response['message'] ?? "Failed to submit quiz");
      }
    } catch (e) {
      Get.back(); // Close loading dialog
      Get.snackbar("Error", "An unexpected error occurred");
      print("Quiz Submission Error: $e");
    }
  }
}
