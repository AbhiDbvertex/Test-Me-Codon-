import 'dart:async';

import 'package:codon/features/test/domain/models/test_model.dart';
import 'package:codon/features/test/domain/services/test_service.dart';
import 'package:codon/features/test/screens/test_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../domain/models/test_result_priview_model.dart';
import '../screens/test_mcq_screen.dart';

class TestsController extends GetxController {
  final TestService _testService = Get.find<TestService>();
  static String? courseId;
  var examSubmitResult = Rxn<ExamSubmitResponseModel>();
  Rx<TestResponseModel?> TestResult = Rx<TestResponseModel?>(null);

  // --- List Screen State ---
  final testCourse = <TestModel>[].obs;
  final examTests = <ExamTestModel>[].obs;
  final groupedTestsByYear = <String, Map<String, List<TestModel>>>{}.obs;
  var isTestCourseLoading = false.obs;
  var isExamTestsLoading = false.obs;
  var startLoadingId = ''.obs;

  // --- MCQ & Timer State ---
  final questionsList = <Map<String, dynamic>>[].obs;
  final currentQuestionIndex = 0.obs;
  final PageController pageController = PageController();
  final userSelections = <String, String?>{}.obs;

  Timer? timer;
  var timeDisplay = "15:00".obs;
  int _totalSeconds = 15 * 60;
  int _remainingSeconds = 0;
  String currentAttemptId = "";
  String currentTestId = "";

  // Flag to stop timer when test is no longer active
  var isTestActive = true.obs;

  @override
  void onInit() {
    super.onInit();
    final testId = Get.arguments;
    if (testId != null) {
      fetchTestPreview(testId);
    }
    fetchExamTests();
  }

  @override
  void onClose() {
    stopTimer();
    isTestActive.value = false;
    pageController.dispose();
    super.onClose();
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
    print("Timer stopped");
  }

  void _loadStaticQuestions() {
    if (questionsList.isNotEmpty) return;
    questionsList.assignAll([
      // your static questions here (same as before)
      {
        "id": "Q101",
        "questionText": "What is the primary function of Mitochondria?",
        "questionImageUrl":
            "https://images.unsplash.com/photo-1530026405186-ed1f139313f8?q=80&w=400&h=200&auto=format&fit=crop",
        "imageTag": "#Cell_Structure_01",
        "correctAnswerId": "opt_2",
        "options": [
          {"id": "opt_1", "text": "Protein Synthesis", "optionImageUrl": null},
          {
            "id": "opt_2",
            "text": "ATP Production (Energy)",
            "optionImageUrl": null,
          },
          {"id": "opt_3", "text": "DNA Replication", "optionImageUrl": null},
          {"id": "opt_4", "text": "Waste Removal", "optionImageUrl": null},
        ],
      },
      // ... other questions
    ]);
    for (var q in questionsList) {
      userSelections.putIfAbsent(q['id'], () => null);
    }
  }

  void startTest({required String testId, required String testTitle}) {
    currentTestId = testId;
    currentQuestionIndex.value = 0;
    if (pageController.hasClients) {
      pageController.jumpToPage(0);
    }
    _loadStaticQuestions();
    _remainingSeconds = _totalSeconds;
    isTestActive.value = true;
    _startTimer();

    Get.to(
      () => const TestMCQScreen(),
      arguments: {'testName': testTitle},
    )?.then((_) {
      stopTimer();
      isTestActive.value = false;
      print("Test screen closed (static test)");
    });
  }

  void startExamTest({required String testId, required String testTitle}) {
    currentTestId = testId;
    startLoadingId.value = testId;

    _apiHandler(
      loader: RxBool(false),
      call: _testService.startExamTest(testId: testId),
      onData: (response) {
        final data = ExamStartResponseModel.fromJson(response);

        currentAttemptId = data.attemptId;
        _remainingSeconds = data.remainingTimeSeconds;

        final mappedQuestions = data.mcqs
            .map(
              (m) => {
                "id": m.mcqId,
                "questionText": m.text,
                "questionImageUrl": m.images.isNotEmpty ? m.images[0] : null,
                "imageTag": m.tag,
                "options": m.options
                    .map(
                      (o) => {
                        "id": o.optionId.toString(),
                        "text": o.name,
                        "optionImageUrl": o.image,
                      },
                    )
                    .toList(),
              },
            )
            .toList();

        questionsList.assignAll(mappedQuestions);
        userSelections.clear();
        for (var q in mappedQuestions) {
          userSelections[q['id'] as String] = null;
        }

        currentQuestionIndex.value = 0;
        if (pageController.hasClients) {
          pageController.jumpToPage(0);
        }

        isTestActive.value = true;
        _startTimer();

        Get.to(
          () => const TestMCQScreen(),
          arguments: {'testName': data.testTitle},
        )?.then((_) {
          stopTimer();
          isTestActive.value = false;
          print("Test screen closed (exam test)");
        });
      },
    ).then((_) {
      startLoadingId.value = '';
    });
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!isTestActive.value) {
        t.cancel();
        return;
      }

      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        int mins = _remainingSeconds ~/ 60;
        int secs = _remainingSeconds % 60;
        timeDisplay.value =
            "${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
      } else {
        submitTest();
      }
    });
  }

  void selectOption(String qId, String optId) {
    userSelections[qId] = optId;
    userSelections.refresh();
    // in getx put call then
    if (currentAttemptId.isNotEmpty) {
      final int? optionId = int.tryParse(optId);
      if (optionId != null) {
        _testService
            .submitExamAnswer(
              attemptId: currentAttemptId,
              mcqId: qId,
              optionId: optionId,
            )
            .then((response) {
              debugPrint("Answer submitted : ${response}");
            })
            .catchError((error) {
              debugPrint("Error submitting answer: $error");
            });
      }
    }
  }

  void onPageChanged(int index) {
    currentQuestionIndex.value = index;
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questionsList.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      submitTest();
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

  void submitTest() {
    stopTimer();

    if (currentAttemptId.isNotEmpty) {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      _testService
          .submitExamTest(attemptId: currentAttemptId)
          .then((response) {
            Get.back();
            final data = ExamSubmitResponseModel.fromJson(response);

            if (data.success) {
              examSubmitResult.value = data;
              Get.off(() => TestResultScreen(testId: currentTestId));
            } else {
              Get.snackbar("Error", "Submission failed");
            }
          })
          .catchError((error) {
            Get.back();
            Get.snackbar("Error", error.toString());
          });
    } else {
      _calculateAndNavigateStatically();
    }
  }

  void _calculateAndNavigateStatically() {
    // your static calculation logic (same as before)
    int correctCount = 0;
    int wrongCount = 0;
    int unattemptedCount = 0;

    for (var q in questionsList) {
      String? selected = userSelections[q['id']];
      if (selected == null) {
        unattemptedCount++;
      } else if (selected == q['correctAnswerId']) {
        correctCount++;
      } else {
        wrongCount++;
      }
    }

    Get.off(() => TestResultScreen(testId: currentTestId));
  }

  Future<TestResponseModel> fetchTestPreview(String testId) async {
    final response = await _testService.getTestPriviewById(testId: testId);
    return TestResponseModel.fromJson(response);
  }

  void fetchExamTests() {
    _apiHandler(
      loader: isExamTestsLoading,
      call: _testService.getExamTests(),
      onData: (response) {
        final rawList = response['data'] as List? ?? [];
        final List<ExamTestModel> allExamTests = rawList
            .map((e) => ExamTestModel.fromJson(e))
            .toList();
        examTests.assignAll(allExamTests);
      },
    );
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
      }
    } catch (e) {
      print("API Error: $e");
    } finally {
      loader(false);
    }
  }
}
