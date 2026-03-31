import 'dart:async';
import 'package:codon/features/qtest/models/custom_test_model.dart';
import 'package:codon/features/qtest/screens/quiz_result_screen.dart';
import 'package:codon/features/qtest/services/qtest_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTestMcqController extends GetxController {
  final CustomTestModel customTest;

  CustomTestMcqController({required this.customTest});

  var currentQuestionIndex = 0.obs;
  var userAnswers = <String, int?>{}.obs; // mcqId -> selectedIndex
  var showExplanation = false.obs;
  final PageController pageController = PageController();

  // Timer state
  Timer? _timer;
  var timeDisplay = "00:00".obs;
  int _remainingSeconds = 0;

  @override
  void onInit() {
    super.onInit();
    _initializeUserAnswers();
    if (customTest.isTimerRequired) {
      _startTimer(customTest.timerMinutes * 60);
    }
  }

  void _initializeUserAnswers() {
    for (var question in customTest.data) {
      userAnswers[question.id] = null;
    }
  }

  void _startTimer(int seconds) {
    _timer?.cancel();
    _remainingSeconds = seconds;
    _updateTimeDisplay();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        _updateTimeDisplay();
      } else {
        _timer?.cancel();
        submitQuiz();
      }
    });
  }

  void _updateTimeDisplay() {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    timeDisplay.value =
        "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  final QTestService _qTestService = Get.find<QTestService>();

  void selectAnswer(int index) {
    final currentQuestion = customTest.data[currentQuestionIndex.value];

    // If already answered, don't allow re-selection
    if (userAnswers[currentQuestion.id] != null) return;

    userAnswers[currentQuestion.id] = index;

    // Save answer to API if attemptId exists
    if (customTest.attemptId != null) {
      _qTestService.saveCustomAnswer(
        attemptId: customTest.attemptId!,
        mcqId: currentQuestion.id,
        selectedIndex: index,
      );
    }
  }

  void toggleExplanation() {
    showExplanation.value = !showExplanation.value;
  }

  void onPageChanged(int index) {
    currentQuestionIndex.value = index;
    showExplanation.value = false;
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < customTest.data.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      submitQuiz();
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<Map<String, dynamic>> submitQuiz() async {
    _timer?.cancel();
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      if (customTest.attemptId != null) {
        final res = await _qTestService.submitCustomTest(
          attemptId: customTest.attemptId!,
        );
        Get.back(); // Close loading

        if (res['success'] == true) {
          final result = res['result'];
          Get.off(
            () => QuizResultScreen(
              targetType: "custom-test",
              chapterId: customTest.attemptId ?? "",
              totalMcqs: result['totalQuestions'] ?? 0,
              correct: result['correct'] ?? 0,
              wrong: result['incorrect'] ?? 0,
              notAttempted: result['notAttempted'] ?? 0,
              questions: customTest.data,
              userAnswers: userAnswers,
            ),
          );
          return res;
        } else {
          Get.snackbar('Error', res['message'] ?? 'Failed to submit test');
          return res;
        }
      } else {
        // Fallback for types without attemptId if any
        _calculateAndNavigateLocally();
        return {'success': true};
      }
    } catch (e) {
      Get.back();
      Get.snackbar("Error", "An unexpected error occurred during submission");
      return {'success': false, 'error': e.toString()};
    }
  }

  void _calculateAndNavigateLocally() {
    int correct = 0;
    int wrong = 0;
    int notAttempted = 0;

    for (var q in customTest.data) {
      int? selected = userAnswers[q.id];
      if (selected == null) {
        notAttempted++;
      } else if (selected == q.correctAnswer) {
        correct++;
      } else {
        wrong++;
      }
    }

    Get.back(); // Close loading
    Get.off(
      () => QuizResultScreen(
        targetType: "custom-test",
        chapterId: customTest.attemptId ?? "",
        totalMcqs: customTest.data.length,
        correct: correct,
        wrong: wrong,
        notAttempted: notAttempted,
        questions: customTest.data,
        userAnswers: userAnswers,
      ),
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
